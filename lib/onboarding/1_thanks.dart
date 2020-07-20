import 'dart:ui';
import 'package:flutter/material.dart';
import '2_getstarted.dart';
import '../resources/backgrounds.dart';

class ThanksPage extends StatelessWidget {

  ThanksPage();

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
              child: Container(),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.all(00.0),
                  child: new Text("Thank You", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                ),
                new Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new Text("Your feedback is critical to making Niteful better.", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                ),
                new Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: new Text("In order to build this habit, we are going to have to send you notifications.", style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
                )
              ],
            )    
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => GetStartedPage()),
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
