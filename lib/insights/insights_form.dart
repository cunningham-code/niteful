import 'dart:ui';
import 'package:flutter/material.dart';
import '../resources/storage.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:local_auth/local_auth.dart';
import 'insights_page.dart';
import 'insight_content.dart';

class InsightsForm extends StatefulWidget {
  final Storage storage = Storage();

  @override
  _InsightsFormState createState() => _InsightsFormState();
}

class _InsightsFormState extends State<InsightsForm> {
  String _input = "";

  int insightNum = 0;

  @override
  void initState() {
    super.initState();
    
    widget.storage.getInsightNum().then((int i) {
      int f = i;
      if(f < 0) {
        f = 0;
      }
      setState(() {
        insightNum = f;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              height: 10
            ),
            new Text(insightStr[insightNum], textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(0, 13, 27, 42), fontSize: 20)),
            new Container(
              height: 10
            ),
            new Container(
              child: new TextField(
                textCapitalization: TextCapitalization.sentences,
                style: new TextStyle(color: Color.fromRGBO(0, 13, 27, 42), fontSize: 20),
                autofocus: false,
                cursorColor: Color.fromRGBO(0, 13, 27, 42),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (newValue) {_input = newValue;}
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 3.0, color: Color.fromRGBO(0, 13, 27, 42)),
                  ),
                ),
              )
            ] 
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color.fromRGBO(0, 13, 27, 42),
          child: new IconButton
          (
              onPressed: () {
                
                widget.storage.addInsights(_input).then((x) {
                  widget.storage.setInsightReaction().then((x) {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => InsightsPage()),
                    );
                  });
                });
                
              },
              icon: new Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}