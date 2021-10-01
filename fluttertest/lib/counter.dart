import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Counter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.only(
          top: 5
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10
      ),
      color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // ignore: prefer_const_constructors
          RawMaterialButton(
            onPressed: (){
              var model = context.read<CounterModel>();
              model.increment();
            },
            elevation: 2.0,
            fillColor: Colors.white,
            child: const Icon(
              Icons.plus_one,
              size: 28.0,
            ),
            padding: const EdgeInsets.all(15.0),
            shape: const CircleBorder(),
          ),
          Consumer<CounterModel>(
              builder: (context, model, child) {
                print(model.value.toString() + ' dd');
                return Text(
                  model.value.toString(),
                  style: const TextStyle(
                      fontSize: 28
                  ),
                );

              }
          ),
        ],
      ),
    );

  }

}

class CounterModel with ChangeNotifier{

  late BuildContext context;
  late SharedPreferences preferences;
  String KEY = "counter";
  int value = 0;

  CounterModel(this.context){
    getValueFromPrefs();
  }

  void increment(){
    value++;
    preferences.setInt(KEY, value);
    notifyListeners();
  }

  void updateValue(int newValue){
    value = newValue;
    notifyListeners();
  }

  void getValueFromPrefs() async{
    preferences = await SharedPreferences.getInstance();
    updateValue(preferences.getInt(KEY) ?? 0);
    print(value);
  }

}

