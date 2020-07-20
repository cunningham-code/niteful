import 'dart:ui';
import 'package:flutter/material.dart';
import 'onboarding/1_thanks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'questions/1_day_form.dart';
import 'insights/insights_page.dart';
import 'package:local_auth/local_auth.dart';
import 'resources/backgrounds.dart';

class Intro extends StatelessWidget {
  void startNiteful(BuildContext c) async {
    var _x = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // RESET INSIGHT
    prefs.setInt("insightNum", -1);
    prefs.setBool("insightReacted", false);

    // CHECK IF TUTORIAL VIEWED
    _x = prefs.getBool("tutorialViewed") ?? false;
    if (_x) {
      Navigator.push(
        c,
        MaterialPageRoute(builder: (context) => DayForm()),
      );
    } else {
      Navigator.push(
        c,
        MaterialPageRoute(builder: (context) => ThanksPage()),
      );
    }
  }

  void skipNiteful(BuildContext c) async {
    var _x = false;
    var _y = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _x = prefs.getBool("tutorialViewed") ?? false;

    if (_x) {
      _y = prefs.getBool("biometrics") ?? false;
      if (_y) {
        var localAuth = LocalAuthentication();
        bool didAuthenticate = await localAuth.authenticateWithBiometrics(
            localizedReason: 'Access Your Niteful Entries');
        if (didAuthenticate) {
          Navigator.push(
            c,
            MaterialPageRoute(builder: (context) => InsightsPage()),
          );
        }
      } else {
        Navigator.push(
          c,
          MaterialPageRoute(builder: (context) => InsightsPage()),
        );
      }
    } else {
      Navigator.push(
        c,
        MaterialPageRoute(builder: (context) => ThanksPage()),
      );
    }
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
              painter: IntroBackground(),
              child: Container(),
            ),
            new GestureDetector(
                onTap: () {
                  startNiteful(context);
                },
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Image.asset(
                      'assets/background-main.png',
                      width: 175,
                    ),
                    new Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            skipNiteful(context);
          },
          backgroundColor: Colors.white,
          icon: new Icon(Icons.info,
              color: Color.fromRGBO(21, 35, 53, 1.0), size: 16),
          label: Text("See Insights",
              style: TextStyle(
                  fontSize: 12, color: Color.fromRGBO(21, 35, 53, 1.0))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
