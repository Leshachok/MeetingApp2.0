import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChoosePlaceMapScreen extends StatefulWidget {
  @override
  _ChoosePlaceMapScreenState createState() => _ChoosePlaceMapScreenState();
}

class _ChoosePlaceMapScreenState extends State<ChoosePlaceMapScreen> {

  final CameraPosition _position =  CameraPosition(target: LatLng(48.515815, 32.250649));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _position,
      ),
    );
  }
}
