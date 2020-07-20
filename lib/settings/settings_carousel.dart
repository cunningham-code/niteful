import 'dart:ui';
import 'package:flutter/material.dart';
import 'settings_page.dart';
import '../insights/insights_page.dart';
import '../resources/storage.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../resources/backgrounds.dart';
import 'settings_cards.dart';

var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

class SettingCarousel extends StatefulWidget {
  final Storage storage = Storage();

  @override
  _SettingCarouselState createState() => _SettingCarouselState();
}

class _SettingCarouselState extends State<SettingCarousel> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new CustomPaint(
              painter: MainBackground(),
              child: Container(
              ),
          ),
          _buildCarousel(context, widget.storage)
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => InsightsPage()),
            );
          },
          backgroundColor: Color.fromRGBO(0, 13, 27, 42),
          
          icon: new Icon(Icons.close, color: Colors.white),
          label: new Text("Close"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildCarousel(BuildContext context, Storage s) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: PageView(
            controller: PageController(viewportFraction: 0.8),
            children: <Widget>[
              _buildCardItem(
                context,
                '1',
                'Gratitude',
                widget.storage,
                [
                  Column(
                    children: <Widget>[
                      Text("Question:", 
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text("What are you thankful for today?", 
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16)
                      ),
                      ),
                      Text("This question is designed to encourage you to practice gratitude.", 
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(0, 13, 27, 42),
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: new FlatButton(
                        child: new Text('Show My Data', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        onPressed: () {
                          widget.storage.getThoughts().then((strs) =>
                             Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => SettingsCards(
                                  'Gratitude Data',
                                  strs,
                                  widget.storage
                                ),
                              )
                            ),
                          );
                        }
                    )
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(0, 13, 27, 42),
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: new FlatButton(
                        child: new Text('Delete My Data', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        onPressed: () => widget.storage.eraseThoughts().then((o) =>
                          showModalBottomSheet<void>(context: context,
                            builder: (BuildContext context) {
                              return new Padding(
                                padding: EdgeInsets.all(20),
                                child: new ListTile(
                                    leading: new Icon(Icons.delete),
                                    title: new Text('Deleted'),
                              ),
                            );
                          })
                        ), 
                      ),
                  ),
                ]
              ),
              _buildCardItem(
                context,
                '2',
                'Initiative',
                widget.storage,
                [
                  Column(
                    children: <Widget>[
                      Text("Question:", 
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text("What is your morning message?", 
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16)
                      ),
                      ),
                      Text("This question is designed to encourage you to plan for your future.", 
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(0, 13, 27, 42),
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: new FlatButton(
                        child: new Text('Show My Data', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        onPressed: () {
                          widget.storage.getMornings().then((strs) =>
                             Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => SettingsCards(
                                  'Initiative Data',
                                  strs,
                                  widget.storage
                                ),
                              )
                            ),
                          );
                        }
                      )
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(0, 13, 27, 42),
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: new FlatButton(
                        child: new Text('Delete My Data', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        onPressed: () => widget.storage.eraseMorning().then((o) =>
                          showModalBottomSheet<void>(context: context,
                            builder: (BuildContext context) {
                              return new Padding(
                                padding: EdgeInsets.all(20),
                                child: new ListTile(
                                    leading: new Icon(Icons.delete),
                                    title: new Text('Deleted'),
                              ),
                            );
                          })
                        ), 
                      ),
                  ),
                ]
              ),
              _buildCardItem(
                context,
                '3',
                'Sentiment',
                widget.storage,
                [
                  Column(
                    children: <Widget>[
                      Text("Question:", 
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text("How was your day?", 
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16)
                      ),
                      ),
                      Text("This question is designed to encourage you to reflect.", 
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(0, 13, 27, 42),
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: new FlatButton(
                        child: new Text('Show My Data', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        onPressed: () {
                          widget.storage.getDailyValues().then((strs) =>
                             Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => SettingsCards(
                                  'Sentiment Data',
                                  strs.map<String>((e) => e.toString()).toList(),
                                  widget.storage
                                ),
                              )
                            ),
                          );
                        }
                      )
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(0, 13, 27, 42),
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: new FlatButton(
                        child: new Text('Delete My Data', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        onPressed: () => widget.storage.eraseDailyValues().then((o) =>
                          showModalBottomSheet<void>(context: context,
                            builder: (BuildContext context) {
                              return new Padding(
                                padding: EdgeInsets.all(20),
                                child: new ListTile(
                                    leading: new Icon(Icons.delete),
                                    title: new Text('Deleted'),
                              ),
                            );
                          })
                        ), 
                      ),
                  ),
                ]
              ),
              _buildCardItem(
                context,
                '4',
                'Reflection',
                widget.storage,
                [
                  Container(
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(0, 13, 27, 42),
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: new FlatButton(
                        child: new Text('Show My Data', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        onPressed: () {
                          widget.storage.getInsights().then((strs) =>
                             Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => SettingsCards(
                                  'Reflection Data',
                                  strs,
                                  widget.storage
                                ),
                              )
                            ),
                          );
                        }
                      )
                  )
                ]
              ),
              _buildCardItem(
                context,
                '5',
                'Personal Settings',
                widget.storage,
                [
                  TextField(
                            onChanged: (s) => 
                              widget.storage.setName(s).then((o) =>
                                print("NAME " + o)
                              ),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 13, 27, 42),
                                fontSize: 16
                              ),
                            decoration: InputDecoration(
                              labelText: "What's your name?",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 13, 27, 42),
                                fontSize: 16
                              ),
                            ),
                            onSubmitted: (s) => 
                              Navigator.pop(context),
                  ),
                  TimePickerFormField(
                        format: DateFormat("h:mm a"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 13, 27, 42),
                            fontSize: 16
                          ),
                        decoration: InputDecoration(
                          labelText: 'When do you typically sleep?',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 13, 27, 42),
                            fontSize: 16
                          ),
                        ),

                        onChanged: (t) => widget.storage.setNightNotificationTime(t),
                  ),
                  TimePickerFormField(
                        format: DateFormat("h:mm a"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 13, 27, 42),
                            fontSize: 16
                          ),
                        decoration: InputDecoration(
                          labelText: 'When do you typically wake up?',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 13, 27, 42),
                            fontSize: 16
                          ),
                        ),
                        onChanged: (t) => widget.storage.setMorningNotificationTime(t),
                  ),
                  RaisedButton(
                    child: new Text('Enable Fingerprint/FaceID'),
                    onPressed: () => widget.storage.setBiometrics(),
                  ),
                ]
              )
            ],
          )
        )
      ],
    );
  }

  Widget _buildCardItem(BuildContext context, String strNum, String title, Storage s, List<Widget> w) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 100),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => SettingsPage(title, w, s)),
          );
        },
        child: Card(
          color: Color.fromRGBO(18, 22, 25, 1.0),
          elevation: 10.0,
          child: Column(
            children: <Widget>[
              new Expanded(
                child: new Stack(children: <Widget>[
                  new Container(
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/tutorial-back.jpg'),
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                  new Container(
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/tutorial/' + strNum + '.png'),
                        fit: BoxFit.scaleDown
                      ),
                    ),
                  ),
                ],
                )
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: new Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        )
      )
    );  
  }
}