import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEventModel with ChangeNotifier{
  LatLng location = LatLng(0, 0);

  void setLocation(LatLng latLng){
    this.location = latLng;
    notifyListeners();
  }

  LatLng getLocation(){
    return location;
  }

}