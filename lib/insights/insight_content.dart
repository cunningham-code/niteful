import 'package:flutter/material.dart';
import 'dart:ui';

class InsightContent extends StatelessWidget
{
  final int insightNum;
  final String payload;
  InsightContent(this.insightNum, this.payload);

  List<Widget> addPayload(int insightNum, String payload) {
    List<Widget> w = insightWidget[insightNum];
    w.insert(0, 
      new Text(payload)
    );
    return w;
  }

  Widget build(BuildContext context)
  {
    
    return new Expanded(
      child: new ListView(
        padding: EdgeInsets.all(25),
        children: insightWidget[insightNum]
      )
    );
    
  }

}

List<List<Widget>> insightWidget = [
  [
    new Text("Loading",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
    )),
  ],
  [
    new Text("It looks like there isn't an insight for you today. Check back tomorrow.",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
    )),
  ],
  [
    new Text("Your daily value seems below what it ususally is.",
      style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    )),
    new Container(height: 20,),
    new Text("It would be a good idea to reach out to someone you trust about your day.",
      style: TextStyle(
      fontSize: 18,
    )),
  ],
            [
              new Text("Your daily value seems higher than average, what about today made it a better than average day?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
              )),
            ],
            [
              new Text("What is the first thing you should do tomorrow morning to realize your morning message?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
              )),
            ],
            [
              new Text("Who could best help you realize your morning message?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
              )),
            ],
            [
              new Text("It looks like that has a name in it. We think it would be a good idea for you to let them know that you appreciated them.",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
              )),
            ],
            [
              new Text("Would you mind giving us an insight? We're working to move Niteful out of beta and we need your feedback.",
                style: TextStyle(
                  fontSize: 18,
              )),
              new Container(height: 15,),
              new Text("Just send a quick text to 619-648-3385",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
              )),
              new Container(height: 15,),
              new Text("We'd really appreciate it.",
                style: TextStyle(
                  fontSize: 16,
              )),
            ]
          ];
      
List<String> insightStr = [
  "Loading",
  "It looks like there isn't an insight for you today. Check back tomorrow.",
  "Your daily value seems below what it ususally is, it would be a good idea to reach out to someone you trust about your day.",
  "Your daily value seems higher than average, what about today made it a better than average day?",
  "What is the first thing you should do tomorrow morning to realize your morning message?",
  "Who could best help you realize your morning message?",
  "It looks like that has a name in it. We think it would be a good idea for you to let them know that you appreciated them.",
  "Would you mind giving us an insight? We're working to move Niteful out of beta and we need your feedback."
];