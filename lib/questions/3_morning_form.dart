import 'dart:ui';
import 'package:flutter/material.dart';
import '../resources/storage.dart';
import 'morning_prompts.dart';
import '../insights/insights_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class MorningForm extends StatefulWidget {
  final Storage storage = Storage();

  @override
  _MorningFormState createState() => _MorningFormState();
}

class _MorningFormState extends State<MorningForm> {
  String _s = "";

  @override
  void initState() {
    super.initState();
  }

  void goToPage() async {
    var _y = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _y = prefs.getBool("biometrics") ?? false;
    if(_y) {
      var localAuth = LocalAuthentication();
      bool didAuthenticate =
            await localAuth.authenticateWithBiometrics(
                localizedReason: 'Access Your Niteful Entries');
      if(didAuthenticate){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => InsightsPage()),
        );          
      }
    } else {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => InsightsPage()),
      );
    }
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
            new MorningPrompts(),
            new Container(
              height: 10
            ),
            new Text("What\'s your morning message?", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 20)),
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
                onChanged: (newValue) {_s = newValue;}
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
                widget.storage.addMorningMessage(_s).then((x) {
                  widget.storage.showMorningNotification(x);
                  goToPage();
                });
              },
              icon: new Icon(Icons.arrow_forward, color: Color.fromRGBO(0, 13, 27, 42)),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}