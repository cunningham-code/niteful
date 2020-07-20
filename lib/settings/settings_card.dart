import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget
{
  final String cardStr;
  SettingsCard(this.cardStr);

  @override
  Widget build(BuildContext context)
  {
    return new Card
    (
      child: new Container
          (
            padding: new EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            child: new Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>
              [
                new Text(cardStr, textAlign: TextAlign.start, style: new TextStyle(fontSize: 23.0, fontWeight: FontWeight.w700)),
                new Padding(padding: new EdgeInsets.only(bottom: 8.0))
              ],
            )
          ),
    );
  }
}