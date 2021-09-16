

import 'package:fluttertest/listsight.dart';
import 'package:fluttertest/counter.dart';
import 'package:flutter/material.dart';

import 'listsight.dart';

void main() => runApp(FlutterApp());

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green
      ),
      home: Content()
    );
  }
}

class Content extends StatefulWidget {
  const Content({Key? key}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}


class _ContentState extends State<Content> {

  List<Widget> navigationWidgets = [];
  int currentWidget = 0;

  @override
  void initState() {
    super.initState();
    navigationWidgets = [
      ListSights(),
      Counter(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample App'),
      ),
      body: navigationWidgets[currentWidget],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) => selectItem(index),
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.orangeAccent,
        backgroundColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            label: "Пам`ятки",
            icon: Icon(
              Icons.menu
            )
          ),
          BottomNavigationBarItem(
              label: "Користувачi",
              icon: Icon(
                  Icons.person_search_sharp
              )
          )
        ],
      ),
    );

  }

  void selectItem(int index) =>
    setState(() => currentWidget = index);
}





