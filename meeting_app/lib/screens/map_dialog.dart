import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meeting_app/model/add_event_model.dart';

class GoogleMapDialog extends StatefulWidget {

  late AddEventModel model;

  GoogleMapDialog(this.model, {Key? key}) : super(key: key);

  @override
  _GoogleMapDialogState createState() => _GoogleMapDialogState(model);
}

class _GoogleMapDialogState extends State<GoogleMapDialog> {

  late AddEventModel model;
  Set<Marker> markers = Set();

  _GoogleMapDialogState(this.model);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: LatLng(45, 45)),
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
      model.setLocation(latLng);
    });
  }
}
