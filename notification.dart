import 'dart:async';
import 'dart:io';
import 'dart:ui';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:http/http.dart' as http;
import 'list.dart';
import 'form.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';

var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/thoughts.txt');
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "";
    }
  }

  Future<File> writeCounter(String s) async {
    final file = await _localFile;

    return file.writeAsString('$s');
  }
}

class NotiScreen extends StatefulWidget {
  final CounterStorage storage = CounterStorage();

  //FormScreen({Key key, @required this.storage}) : super(key: key);

  @override
  _NotiScreenState createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  String _s = "";
  List<String> _lst = [];

  @override
  void initState() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    
    super.initState();
    widget.storage.readCounter().then((String v) {
      setState(() {
        _s = v;
      });
      _lst = _s.split("~");

      List<String> _newLst = [];
      for(int c = 0; c < _lst.length; c++) {
        
        if(_lst[c].length >= 1) {
          _newLst.add(_lst[c]);
        }
      }

      _lst = _newLst;
    });
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => FormScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    int _hour = 10;
    int _minute = 30;
    final timeFormat = DateFormat("h:mm a");
    TimeOfDay _time;

    return Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: Color.fromRGBO(0, 13, 27, 42)),
          child: Center(
            child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("Remind Yourself",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30
                    ),
                ),
                TimePickerFormField(
                  format: timeFormat,
                  decoration: InputDecoration(
                    labelText: 'Set A Time'
                    
                  ),
                  onChanged: (t) => _showDailyAtTime(t),
                ),
                /*
                new Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                  style: new TextStyle(color: Colors.white, fontSize: 16),
                  decoration: new InputDecoration(
                    hintText: "Enter hour (24 hour)",
                    hintStyle: TextStyle(color: Colors.white24),
                    border: InputBorder.none
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (h) => _hour = int.parse(h),
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    style: new TextStyle(color: Colors.white, fontSize: 16),
                    decoration: new InputDecoration(
                      hintText: "Enter minute",
                      hintStyle: TextStyle(color: Colors.white24),
                      border: InputBorder.none
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (m) => _minute = int.parse(m),
                  ),
                ),
               
                new Padding(
                    padding: new EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 8.0),
                    child: new RaisedButton(
                      child: new Text('Notify Me'),
                      onPressed: () => 
                        
                      
                  ),
                ),
                 */
              ],
            ),
          ),
        ),
      )
    );
  }

  Future _showNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Success!', 'We will notify you.', platformChannelSpecifics,
        payload: 'item x');
  }

  Future _showDailyAtTime(TimeOfDay t) async {
    print(t.hour);
    print(t.minute);
    var time = new Time(t.hour, t.minute, 0);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '0000',
        'Sleep Reminders',
        'Reminders to go to sleep set by the user.');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Time to sleep.',
        'Let\'s wrap up today with something you are thankful for.',
        time,
        platformChannelSpecifics);

    //_showNotification();

    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => ListScreen()),
    );
  }

  

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }
  
}
