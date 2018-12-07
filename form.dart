import 'dart:async';
import 'dart:io';
import 'dart:ui';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:http/http.dart' as http;
import 'list.dart';


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

class FormScreen extends StatefulWidget {
  final CounterStorage storage = CounterStorage();

  //FormScreen({Key key, @required this.storage}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String _s = "";
  List<String> _lst = [];
  String _input = "";

  @override
  void initState() {
    
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
  }

  Future<File> _incrementCounter(String n) async {
    setState(() {
      String temp = n.replaceAll("~", "");
      _s = temp + "~" + _s;
    });

    _lst = _s.split("~");

    List<String> _newLst = [];
    for(int c = 0; c < _lst.length; c++) {
      if(_lst[c].length >= 1) {
        _newLst.add(_lst[c]);
      }
    }

    _lst = _newLst;

    

    return widget.storage.writeCounter(_s);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: Color.fromRGBO(0, 13, 27, 42)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: TextField(
                    style: new TextStyle(color: Colors.white, fontSize: 20),
                    autofocus: false,
                    cursorColor: Colors.white24,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What are you thankful for today?',
                      hintStyle: TextStyle(color: Colors.white24)
                    ),
                    onChanged: (newValue) {_input = newValue;}
                  ),
                ),
                
                new Padding(
                    padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                    child: new RaisedButton(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black
                      ),
                      onPressed: () {
                        _incrementCounter(_input);
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => ListScreen()),
                        );
                      },
                    ),
                  ),
                  
              ],
            ),
          ),
        )
      );
  }

  /*
  Future _showNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Hello World', 'Hopefully you see this??', platformChannelSpecifics,
        payload: 'item x');
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }
  */
}
