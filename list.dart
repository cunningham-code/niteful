import 'dart:async';
import 'dart:io';
import 'dart:ui';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:http/http.dart' as http;
import 'notification.dart';

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

class ListScreen extends StatefulWidget {
  final CounterStorage storage = CounterStorage();

  //ListScreen({Key key, @required this.storage}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String _s = "";
  List<String> _lst = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: Color.fromRGBO(0, 13, 27, 42)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: _lst.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(
                        '${_lst[index]}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 13, 27, 42),
                          fontSize: 30
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ), 
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          tooltip: 'Toggle',
          child: Icon(
            Icons.notification_important,
            color: Colors.black
          ),
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => NotiScreen()),
            );
          }
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
