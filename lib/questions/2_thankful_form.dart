import 'dart:ui';
import 'package:flutter/material.dart';
import '3_morning_form.dart';
import '../resources/storage.dart';
import 'thankful_prompts.dart';
import 'package:flutter/services.dart';


class ThankfulForm extends StatefulWidget {
  final Storage storage = Storage();

  @override
  _ThankfulFormState createState() => _ThankfulFormState();
}

class _ThankfulFormState extends State<ThankfulForm> {
  String _input = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 13, 27, 42),
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ThankfulPrompts(),
            new Container(
              height: 10
            ),
            new Text("What are you thankful for today?", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 20)),
            new Container(
              height: 10
            ),
            new Container(
              child: new TextField(
                textCapitalization: TextCapitalization.sentences,
                style: new TextStyle(color: Colors.white, fontSize: 20),
                autofocus: false,
                cursorColor: Colors.white24,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (newValue) {_input = newValue;}
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 3.0, color: Colors.white),
                  ),
                ),
              )
            ] 
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          child: new IconButton
          (
              onPressed: () {
                widget.storage.addThought(_input).then((x) {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => MorningForm()),
                  );
                });
              },
              icon: new Icon(Icons.arrow_forward, color: Color.fromRGBO(0, 13, 27, 42)),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}