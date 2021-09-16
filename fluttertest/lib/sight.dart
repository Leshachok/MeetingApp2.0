import 'dart:convert';

class Sight{

  final double longitude;
  final double latitude;
  final String title;
  final String snippet;
  final String imagetitle;
  final String guid;
  final int radius;

  const Sight({
    required this.longitude,
    required this.latitude,
    required this.title,
    required this.snippet,
    required this.imagetitle,
    required this.guid,
    required this.radius,
  });


  factory Sight.fromJson(Map<String, dynamic> data){
    var string = "";
    var title = data['title'] as String;
    var bytes = title.codeUnits;
    title = utf8.decode(bytes);

    string = data['snippet'] as String;
    bytes = string.codeUnits;
    var snippet = utf8.decode(bytes);

    string = data['imagetitle'] as String;
    bytes = string.codeUnits;
    var imagetitle = utf8.decode(bytes);

    return Sight(
        longitude: data['longitude'] as double,
        latitude: data['latitude'] as double,
        title: title,
        snippet: snippet,
        imagetitle: imagetitle,
        guid: data['guid'] as String,
        radius: data['radius'] as int
    );
  }

}