import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  int counter = 0;
  late SharedPreferences preferences;
  String KEY = "counter";

  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  void initPreferences() async{
    preferences = await SharedPreferences.getInstance();
    counter = preferences.getInt(KEY) ?? 0;
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 30
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 10
        ),
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // ignore: prefer_const_constructors
            RawMaterialButton(
              onPressed: increment,
              elevation: 2.0,
              fillColor: Colors.white,
              child: const Icon(
                Icons.plus_one,
                size: 35.0,
              ),
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
            ),
            Text(
              counter.toString(),
              style: const TextStyle(
                fontSize: 35
              ),
            ),
          ],
        ),
      ),
    );
  }

  void increment(){
    counter++;
    setState(() {});
    preferences.setInt(KEY, counter);
    Fluttertoast.showToast(
        msg: "Counter value is " + counter.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}
