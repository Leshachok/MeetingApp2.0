import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meeting_app/model/add_event_model.dart';

import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/search.dart';


class GoogleMapDialog extends StatefulWidget {

  late AddEventModel model;

  GoogleMapDialog(this.model, {Key? key}) : super(key: key);

  @override
  _GoogleMapDialogState createState() => _GoogleMapDialogState(model);
}

class _GoogleMapDialogState extends State<GoogleMapDialog> {

  late AddEventModel model;
  late SearchEngine _onlineSearchEngine;
  Set<Marker> markers = Set();

  _GoogleMapDialogState(this.model);

  @override
  void initState() {
    SdkContext.init();
    _onlineSearchEngine = SearchEngine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GoogleMap(
      initialCameraPosition: const CameraPosition(target: LatLng(48.835, 31.463)),
      markers: markers,
      onTap: onMapTapped,
    );
  }

  void onMapTapped(LatLng latLng){
    setState(() {
      markers.add(
          Marker(
              markerId: MarkerId('chosen position'),
            position: latLng
          )
      );
      GeoCoordinates coordinates = GeoCoordinates(latLng.latitude, latLng.longitude);
      _getAddressForCoordinates(coordinates);
    });
  }


  Future<void> _getAddressForCoordinates(GeoCoordinates geoCoordinates) async {
    int maxItems = 1;
    SearchOptions reverseGeocodingOptions = SearchOptions(LanguageCode.enGb, maxItems);
    SearchEngine _onlineSearchEngine = SearchEngine();

    _onlineSearchEngine.searchByCoordinates(geoCoordinates, reverseGeocodingOptions,
            (SearchError? searchError, List<Place>? list) async {
              _handleGeocodingResults(searchError, list);
    });
  }

  void _handleGeocodingResults(SearchError? searchError, List<Place>? list){
    if (searchError != null) {
      print("Geocoding Error: " + searchError.toString());
      return;
    }

    for (var place in list!){
      if(place.address.street!= '' && place.address.city != ''){
        model.setLocation(place.address.city + ', '+ place.address.street);
        break;
      }
    }

  }


}
