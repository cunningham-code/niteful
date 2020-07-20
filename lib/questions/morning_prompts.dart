import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';

class MorningPrompts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MorningPromptsState();
}

class _MorningPromptsState extends State<MorningPrompts> {
  Timer _timer;
  List<Widget> _w = [
    new Container()
  ];

  _MorningPromptsState() {
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
                        child: new Text("Is there anything you need to do tomorrow that’s not in your routine?", style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left),
                      ),
                      new Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: new Text("What’s the first thing you want to do tomorrow?", style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left),
                      ),
                      new Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: new Text('Give yourself some positive motivation for tomorrow morning!', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left),
                      ),
                      new Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: new Text('What should you keep in mind tomorrow?', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left),
                      ),
                      new Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: new Text('What are you looking to accomplish?', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left),
                      ),
                      new Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: new Text('What frame of mind would be best for yourself tomorrow?', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.left),
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
              child: new Text("Need Help?", style: TextStyle(fontSize: 16, color: Colors.white54))
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