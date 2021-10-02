import 'package:flutter/material.dart';
import 'package:meeting_app/model/add_event_model.dart';
import 'package:meeting_app/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:here_sdk/core.dart';

import 'package:here_sdk/mapview.dart';
import 'model/event_model.dart';

void main() {

  SdkContext.init(IsolateOrigin.main);
  runApp(MeetingApp());
}

class MeetingApp extends StatefulWidget {
  @override
  _MeetingAppState createState() => _MeetingAppState();
}

class _MeetingAppState extends State<MeetingApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => EventModel()),
        ChangeNotifierProvider(
            create: (_) => AddEventModel()),
      ],
      child: MaterialApp(
        title: 'Meeting App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red
        ),
        home: MainScreen(),
      ),
    );
  }


}


