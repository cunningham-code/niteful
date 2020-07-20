import 'dart:ui';
import 'package:flutter/material.dart';
import 'insights_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class InsightsReactButton extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _InsightsReactButtonState();
}

class _InsightsReactButtonState extends State<InsightsReactButton> {
 
  Widget _w = new Container();
  
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
     _w =  new FlatButton.icon(
          icon: Icon(Icons.system_update_alt, size: 30, color: Colors.grey),
          label: Text("Loading", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey)),
          onPressed: () {
          },
        );
  }

  Future<bool> setW() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  _InsightsReactButtonState() {

    setW().then((a) {
      bool x = prefs.getBool("insightReacted");
      print("X is " + x.toString());

      if(x) {
          _w = new FlatButton.icon(
            icon: Icon(Icons.question_answer, size: 30, color: Colors.grey),
            label: Text("Reflect", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey)),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => InsightsForm()),
              );
            },
          );
        } else {
          _w = new FlatButton.icon(
            icon: Icon(Icons.question_answer, size: 30, color: Color.fromRGBO(0, 13, 27, 42)),
            label: Text("Reflect", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color.fromRGBO(0, 13, 27, 42))),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => InsightsForm()),
              );
            },
          );
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return _w;
  }
}