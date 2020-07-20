import 'dart:ui';
import 'package:flutter/material.dart';
import '../questions/1_day_form.dart';
import '../settings/settings_page.dart';
import '../resources/storage.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import '../resources/backgrounds.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

class GetStartedPage extends StatefulWidget {
  final Storage storage = Storage();

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStartedPage> {

  @override
  void initState() {
    super.initState();
    enableNotifications();
  }

  void setTutorialViewed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("tutorialViewed", true);
  }

  Future onSelectNotification(String payload) async {
    print("HELLO " + payload);

    if((payload.length >= 2)&&(payload.substring(0, 2) == 'M:')) {
      showModalBottomSheet<void>(context: context,
        builder: (BuildContext context) {
          return new Scaffold(
            body: Padding(
              padding: EdgeInsets.all(30),
              child: Text(payload.substring(2)),
            ),
          );
      });
    }
  }

  void enableNotifications() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            new CustomPaint(
              painter: MainBackground(),
              child: Container(
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.all(00.0),
                  child: new Text("Let's get started.", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                ),
                new Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new Text("Niteful helps you set and achieve your mental wellbeing goals by prompting you every night with a few questions to wrap up your day.", style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
                ),
                new GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => SettingsPage('Personal Settings', 
                        [
                          TextField(
                                    onChanged: (s) => 
                                      widget.storage.setName(s).then((o) =>
                                        print("NAME " + o)
                                      ),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(0, 13, 27, 42),
                                        fontSize: 16
                                      ),
                                    decoration: InputDecoration(
                                      labelText: "What's your name?",
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(0, 13, 27, 42),
                                        fontSize: 16
                                      ),
                                    ),
                                    onSubmitted: (s) => 
                                      Navigator.pop(context),
                          ),
                          TimePickerFormField(
                                format: DateFormat("h:mm a"),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(0, 13, 27, 42),
                                    fontSize: 16
                                  ),
                                decoration: InputDecoration(
                                  labelText: 'When do you typically sleep?',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(0, 13, 27, 42),
                                    fontSize: 16
                                  ),
                                ),

                                onChanged: (t) => widget.storage.setNightNotificationTime(t),
                          ),
                          TimePickerFormField(
                                format: DateFormat("h:mm a"),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(0, 13, 27, 42),
                                    fontSize: 16
                                  ),
                                decoration: InputDecoration(
                                  labelText: 'When do you typically wake up?',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(0, 13, 27, 42),
                                    fontSize: 16
                                  ),
                                ),
                                onChanged: (t) => widget.storage.setMorningNotificationTime(t),
                          ),
                          RaisedButton(
                            child: new Text('Enable Fingerprint/FaceID'),
                            onPressed: () => widget.storage.setBiometrics(),
                          ),
                        ]
                        , widget.storage)
                      ),
                    );
                  },
                  child: new Card(
                  elevation: 10.0,
                  color: Color.fromRGBO(0, 13, 27, 42),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text("Set Personal Settings", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    )
                  )
                ),
                )
              ],
            )    
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setTutorialViewed();
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => DayForm()),
            );
          },
          backgroundColor: Color.fromRGBO(0, 13, 27, 42),
          child: new Icon(Icons.arrow_forward, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
