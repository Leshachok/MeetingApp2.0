
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertest/sight.dart';
import 'package:http/http.dart' as http;

class ListFragment extends StatefulWidget {
  const ListFragment({Key? key}) : super(key: key);

  @override
  _ListFragmentState createState() => _ListFragmentState();
}

class _ListFragmentState extends State<ListFragment> {

  List<Sight> sights = [];
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSights();
    controller.addListener(() {

      double value = controller.offset/260;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
      ListView.builder(
        controller: controller,
        itemCount: sights.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int position) {
          double scale = 1.0;
          if(topContainer > 1){
            scale = position + 1 - topContainer;
            if(scale < 0){
              scale = 0;
            }else if (scale > 1){
              scale = 1;
            }
          }
          return Opacity(
            opacity: scale,
            child: Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()..scale(scale, scale),
              child: getRow(position),
            ),
          );
        },
      )
    );
  }

  Widget getRow(int i) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.green,
          boxShadow: [
              BoxShadow(
                  color: Colors.black.withAlpha(100),
                  blurRadius: 10.0
              ),
          ]),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            getContainer("Опис: " + sights[i].snippet),
            getContainer('Координати: [' + sights[i].longitude.toString() + ', ' + sights[i].latitude.toString() + ']'),
            getContainer('Тип: ' + sights[i].imagetitle),
            getContainer('Радiус: ' + sights[i].radius.toString()),
            getContainer('ID: ' + sights[i].guid),
          ]
      ),

    );
  }

  Container getContainer(String text){
    return Container(
      child: Text(text),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
