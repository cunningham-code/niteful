import 'package:flutter/material.dart';
import 'dart:ui';
import '../settings/settings_carousel.dart';
import '../resources/storage.dart';
import 'insight_content.dart';
import 'dart:math';
import 'insights_form.dart';
import 'intisghts_react_button.dart';
import '../settings/settings_cards.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InsightsPage extends StatefulWidget
{
  final Storage storage = Storage();
  
  @override
  _InsightsPageState createState() => new _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage>
{
    int insightNum = 0;
    String payload = "";

    @override
    void initState()
    {
      super.initState();
      widget.storage.checkSettings();
      /*
      appreciateCards();
      setState(() {
        topLabel = "Appreciate"; 
      });

      setState(() {
        insightNum = generateInsights();
        print("IN: " + insightNum.toString());
      });
      */

      generateInsights();
    }

    /*
    void appreciateCards() {
      widget.storage.getThoughts().then((List<String> l) {
        
        List<ThoughtCard> newcards = new List();
        l.forEach((x) => newcards.add(new ThoughtCard(x)));
        while(newcards.length < 3) {
          newcards.add(new ThoughtCard("Add more thoughts for these placeholder cards to go away."));
        }
        setState(() {
          cards = newcards;  
        });
      });
    }
    */

    void generateInsights() {
      
      List<int> insightNums = [];

      List<String> thankfuls;
      List<String> mornings;
      List<int> dailyValues;
      widget.storage.getThoughts().then((List<String> t) {
        thankfuls = t;
        widget.storage.getMornings().then((List<String> m) {
          mornings = m;
          widget.storage.getDailyValues().then((List<int> dv) {
            dailyValues = dv;

            /*
            CRAZY INSIGHT CODE
            */

            widget.storage.getInsightNum().then((int i) {

              if(i >= 0) {

                /*
                INSIGHT ALREADY SET
                */
                print("INSIGHT ALREADY SENT");

                String p = "";

                switch (i) {
                  case 4:
                    p = mornings[0];
                    break;
                  case 5: 
                    p = mornings[0];
                    break;
                  case 6: 
                    p = thankfuls[0];
                    break;
                }

                setState(() {
                  insightNum = i;
                  payload = p;
                });

              } else {

                /*
                INSIGHT NOT SET
                */
                print("INSIGHT NOT ALREADY SENT");

                if(dailyValues.length > 2) {
                  double sum = 0;
                  dailyValues.forEach((x) => sum += x);
                  int len = dailyValues.length;
                  double average = 0;
                  if(len != 0) {
                    average = sum / len;
                  }
                  double finalAverage = average.round() / 10;
                  double currentValue = dailyValues[0] / 10;

                  if(currentValue > finalAverage) {
                    insightNums.add(3);
                  }

                  if(currentValue < finalAverage) {
                    insightNums.add(2);
                  }

                  double difference = currentValue - finalAverage;
                  if((difference < -3) || (currentValue <= 3)) {
                    setState(() {
                      insightNum = 2;
                      payload = "";
                    });
                  }
                }

                if(mornings.length >= 1) {
                  insightNums.add(4);
                  insightNums.add(5);
                }

                if(thankfuls.length >= 1) {
                  insightNums.add(6);
                }

                if(((dailyValues.length > 2) && (mornings.length > 2)) && (thankfuls.length > 2)) {
                  insightNums.add(1);
                  insightNums.add(1);
                  insightNums.add(7);
                } 
                

                var rng = new Random();
                
                String p = "";
                int finalVal = insightNums[rng.nextInt(insightNums.length)];

                switch (finalVal) {
                  case 4:
                    p = mornings[0];
                    break;
                  case 5: 
                    p = mornings[0];
                    break;
                  case 6: 
                    p = thankfuls[0];
                    break;
                }

                widget.storage.setInsightNum(finalVal);

                setState(() {
                  insightNum = finalVal;
                  payload = p;
                });
                print(p);
              }
            });
            
            /*
            CRAZY INSIGHT CODE
            */
          });
        });
      });
    }

    /*
    void focusCards() {
      widget.storage.getMornings().then((List<String> l) {
        
        List<ThoughtCard> newcards = new List();
        l.forEach((x) => newcards.add(new ThoughtCard(x)));
        while(newcards.length < 3) {
          newcards.add(new ThoughtCard("Leave more morning messages for these placeholder cards to go away."));
        }

        setState(() {
          cards = newcards;  
        });
      });
    }
    */

    /*
    void reflectCards() {
      widget.storage.getDailyValues().then((List<int> l) {
        
        List<ThoughtCard> newcards = new List();
        double sum = 0;
        l.forEach((x) => sum += x);
        int len = l.length;
        double average = 0;
        if(len != 0) {
          average = sum / len;
        }

        double finalAverage = average.round() / 10;
        newcards.add(new ThoughtCard("Your average daily number is " + finalAverage.toString()));
        
        List<int> short = l;
        if(l.length > 5) {
          short = l.sublist(0, 5);
        }
        newcards.add(new ThoughtCard("Your most recent numbers were: " + short.toString()));

        String insight = "You need more data for insights.";
        if(l.length >= 3) {
          if((l[0] < l[1]) & (l[1] < l[2])) {
            insight = "Your daily values seem to have a downward trend.";
          } else if((l[0] >= l[1]) & (l[1] >= l[2])) {
            insight = "Your daily values seem to have an upward trend.";
          }
        }

        newcards.add(new ThoughtCard(insight));

        setState(() {
          cards = newcards;  
        });
      });
    }
    */

    /*
    void changeCardsOrder()
    {
      setState(()
      {
        cards.add(cards.removeAt(0));
      });
    }
    */

    /*
    Widget dragTarget()
    {
      return new Flexible
      (
        flex: 1,
        child: new DragTarget
        (
          builder: (_, __, ___)
          {
            return new Container(color: Colors.transparent);
          },
          onWillAccept: (_)
          {
            setState(() => dragOverTarget = true);
            return true;
          },
          onAccept: (_)
          {
            changeCardsOrder();
            setState(() => dragOverTarget = false);
          },
          onLeave: (_) => setState(() => dragOverTarget = false)
        ),
      );
    }
    */

  @override
  Widget build(BuildContext context)
  {
    return new Scaffold
    (
      appBar: new AppBar
      (
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 13, 27, 42),
        /*
        leading: new IconButton
        (
          onPressed: () {
            
          },
          icon: new Icon(Icons.question_answer, color: Colors.white)
        ),
        */
        title: new Padding(
          child: Image.asset('assets/background-tsp.png', scale: 0.5),
          padding: EdgeInsets.all(8.0),
        ),
        actions: <Widget>
        [
          new IconButton
          (
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => SettingCarousel()),
              );
            },
            icon: new Icon(Icons.settings, color: Colors.white)
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(0, 13, 27, 42),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: new Column
      (
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>
        [
          new Padding(
                padding: EdgeInsets.all(20),
                child: new Text("Here is your insight for today.",
                  style: TextStyle(color: Colors.white, fontSize: 18)
                ),
              ),
          new Expanded(
            child: new Card(
              child: Column(
                children: <Widget>[
                  new InsightContent(insightNum, payload),
                  new Padding(
                    padding: EdgeInsets.all(15),
                    child: new InsightsReactButton()
                  )
                ],
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.all(50),
            child: new FlatButton.icon(
                icon: Icon(FontAwesomeIcons.archive, size: 25, color: Colors.white),
                label: Text("See More", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)
                ),
                onPressed: () { 
                   showModalBottomSheet<void>(context: context,
                      builder: (BuildContext context) {
                        return new Scaffold(
                          backgroundColor: Color.fromRGBO(18, 22, 25, 1.0),
                          body: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Container(
                                height: 10
                              ),
                              new Padding(
                                padding: EdgeInsets.all(10),
                                child: new ListTile(
                                  leading: new Icon(FontAwesomeIcons.handsHelping, color: Colors.white, size: 30),
                                  title: new Text('Gratitude', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                  onTap: () {
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
                                  },          
                                ),
                              ),
                              new Padding(
                                padding: EdgeInsets.all(10),
                                child: new ListTile(
                                  leading: new Icon(FontAwesomeIcons.chartLine, color: Colors.white, size: 30),
                                  title: new Text('Initiative', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                  onTap: () {
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
                                  },       
                                ),
                              ),
                              new Padding(
                                padding: EdgeInsets.all(10),
                                child: new ListTile(
                                  leading: new Icon(FontAwesomeIcons.circleNotch, color: Colors.white, size: 30),
                                  title: new Text('Sentiment', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                  onTap: () {
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
                                  },   
                                ),
                              ),
                              new Padding(
                                padding: EdgeInsets.all(10),
                                child: new ListTile(
                                  leading: new Icon(FontAwesomeIcons.clipboard, color: Colors.white, size: 30),
                                  title: new Text('Reflection', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                  onTap: () {
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
                                  },   
                                ),
                              ),
                            ]
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
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 3.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }  
}
