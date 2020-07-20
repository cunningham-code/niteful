
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../resources/backgrounds.dart';
import '../resources/storage.dart';

var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

class SettingsPage extends StatelessWidget {

  final String title;
  final List<Widget> w;
  final Storage s;
  SettingsPage(this.title, this.w, this.s);

  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: new AppBar(
          leading: new IconButton
          (
            onPressed: () {
              Navigator.pop(context);
            },
            icon: new Icon(Icons.arrow_back, color: Colors.white)
          ),
          backgroundColor: Color.fromRGBO(18, 22, 25, 1.0),
          title: new Text(title, style: TextStyle(color: Colors.white))
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            new CustomPaint(
                painter: SettingsBackground(),
                child: Container(
                ),
            ),
            ListView.builder(
              itemCount: w.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  elevation: 10.0,
                  child: new Padding(
                      padding: EdgeInsets.all(20.0),
                      child: w[index]
                    )
                  );
              }
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: Colors.white,
          
          icon: new Icon(Icons.save, color: Color.fromRGBO(18, 22, 25, 1.0)),
          label: new Text("Save", style: TextStyle(color: Color.fromRGBO(18, 22, 25, 1.0))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}
