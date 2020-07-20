import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';

class ThankfulPrompts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ThankfulPromptsState();
}

class _ThankfulPromptsState extends State<ThankfulPrompts> {
  Timer _timer;
  List<Widget> _w = [
    new Container()
  ];

  _ThankfulPromptsState() {
    _timer = new Timer(const Duration(milliseconds: 10000), () {
      setState(() {
        _w = [
          new GestureDetector(
            onTap: () { 
              showModalBottomSheet<void>(context: context,
                        builder: (BuildContext context) {
                          return new Scaffold(
                            backgroundColor: Color.fromRGBO(18, 22, 25, 1.0),
                            body: ListView(
                            padding: EdgeInsets.all(20),
                            children: <Widget>[
                              new Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                  child: new Text('Did anyone lend you a hand today?', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left),
                                ),
                                new Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                  child: new Text('Did something go well?', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left),
                                ),
                                new Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                  child: new Text('Did you accomplish something?', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left),
                                ),
                                new Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                  child: new Text('Did someone do something they didn’t have to do for you?', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left),
                                ),
                                new Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                  child: new Text('Did anyone reach out to you?', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left),
                                ),
                                new Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                  child: new Text('Did someone help you?', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left),
                                ),
                            ],
                          ),
                          floatingActionButton: FloatingActionButton(
                              onPressed: () {},
                              backgroundColor: Colors.white,
                              child: new IconButton
                              (
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: new Icon(Icons.close, color: Color.fromRGBO(0, 13, 27, 42)),
                              ),
                            ),
                            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
                        );
                      });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: new Text("Need Help?", style: TextStyle(fontSize: 18, color: Colors.white54))
              )
          )
        ];
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: _w,
    );
  }
}

/*



*/