
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/sight.dart';
import 'package:http/http.dart' as http;

class ListSights extends StatefulWidget {
  const ListSights({Key? key}) : super(key: key);

  @override
  _ListSightsState createState() => _ListSightsState();
}

class _ListSightsState extends State<ListSights> {

  List<Sight> sights = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSights();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sights.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      },
    );
  }

  Widget getRow(int i) {
    return Container(

      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.green,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Center(
                  child: Text(sights[i].title,
                    style: TextStyle(
                        fontSize: 30),
                        ),
                    ),
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            Container(
              child: Text("Опис: " + sights[i].snippet),
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            Container(
              child: Text('Координати: [' + sights[i].longitude.toString() + ', ' + sights[i].latitude.toString() + ']'),
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            Container(
              child: Text('Тип: ' + sights[i].imagetitle),
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            Container(
              child: Text('Радiус: ' + sights[i].radius.toString()),
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            Container(
              child: Text('ID: ' + sights[i].guid),
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
          ]
      ),

    );
  }

  Future<void> getSights() async{
    var url = "https://stats.pnit.od.ua/ukromap/sights";
    var response = await http.post(Uri.parse(url));
    var json = response.body;
    Map<String, dynamic> body = jsonDecode(json);

    List<dynamic> data = body['data'];
    List<Sight> sights = data.map<Sight>((json) => Sight.fromJson(json)).toList();
    setState(() => this.sights = sights);
  }

}
