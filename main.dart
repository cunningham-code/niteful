import 'package:flutter/material.dart';
import 'form.dart';

void main() {
  runApp(new MainApp());
}

class MainApp extends StatefulWidget {
  @override
    State<StatefulWidget> createState() => new _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
    Widget build(BuildContext context) {

      return new MaterialApp(
        title: 'Niteful',
        home: new FormScreen()
      );
    }
}