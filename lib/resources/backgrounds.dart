import 'dart:ui';
import 'package:flutter/material.dart';

class IntroBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    Path mainBGPath = Path();
    mainBGPath.addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    paint.color = Color.fromRGBO(18, 22, 25, 1.0);
    canvas.drawPath(mainBGPath, paint);

    Path bottomPath = Path();
    bottomPath.lineTo(size.width *.2, 0);
    bottomPath.lineTo(0, size.height * .3);
    bottomPath.close();
    paint.color = Color.fromRGBO(21, 35, 53, 1.0);
    canvas.drawPath(bottomPath, paint);

    Path trianglePath = Path();
    trianglePath.lineTo(size.width *.3, 0);
    trianglePath.lineTo(0, size.height * .2);
    trianglePath.close();
    paint.color = Color.fromRGBO(108, 207, 246, 1.0);
    canvas.drawPath(trianglePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

}

class MainBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    Path mainBGPath = Path();
    mainBGPath.addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    paint.color = Color.fromRGBO(229, 239, 247, 1.0);
    canvas.drawPath(mainBGPath, paint);

    Path redPath = Path();
    redPath.moveTo(size.width * 0.9 , 0.0);
    redPath.quadraticBezierTo(size.width * .5, size.height * 0.1, 0, size.height * 0.85);
    redPath.lineTo(0, size.height);
    redPath.lineTo(size.width * 0.25, size.height);
    redPath.quadraticBezierTo(size.width * .5, size.height * 0.7, size.width, size.height * 0.6);
    redPath.lineTo(size.width, 0.0);
    redPath.close();
    paint.color = Color.fromRGBO(221, 240, 255, 1.0);
    canvas.drawPath(redPath, paint);
    
    Path orangePath = Path();
    orangePath.moveTo(0, size.height * 0.55);
    orangePath.quadraticBezierTo(size.width * .25, size.height * 0.65, size.width * .40, size.height);
    orangePath.lineTo(0, size.height);
    orangePath.close();
    paint.color = Color.fromRGBO(164, 221, 244, 1.0);
    canvas.drawPath(orangePath, paint);

    Path trianglePath = Path();
    trianglePath.lineTo(size.width *.55, 0);
    trianglePath.lineTo(0, size.height * .35);
    trianglePath.close();
    paint.color = Color.fromRGBO(186, 217, 244, 1.0);
    canvas.drawPath(trianglePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

}

class SettingsBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    Path mainBGPath = Path();
    mainBGPath.addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    paint.color = Color.fromRGBO(18, 22, 25, 1.0);
    canvas.drawPath(mainBGPath, paint);

    Path redPath = Path();
    redPath.moveTo(size.width * 0.9 , 0.0);
    redPath.quadraticBezierTo(size.width * .5, size.height * 0.1, 0, size.height * 0.85);
    redPath.lineTo(0, size.height);
    redPath.lineTo(size.width * 0.25, size.height);
    redPath.quadraticBezierTo(size.width * .5, size.height * 0.7, size.width, size.height * 0.6);
    redPath.lineTo(size.width, 0.0);
    redPath.close();
    paint.color = Color.fromRGBO(46, 64, 87, 1.0);
    canvas.drawPath(redPath, paint);
    
    Path orangePath = Path();
    orangePath.moveTo(0, size.height * 0.55);
    orangePath.quadraticBezierTo(size.width * .25, size.height * 0.65, size.width * .40, size.height);
    orangePath.lineTo(0, size.height);
    orangePath.close();
    paint.color = Color.fromRGBO(40, 71, 94, 1.0);
    canvas.drawPath(orangePath, paint);

    Path trianglePath = Path();
    trianglePath.lineTo(size.width *.55, 0);
    trianglePath.lineTo(0, size.height * .35);
    trianglePath.close();
    paint.color = Color.fromRGBO(11, 19, 43, 1.0);
    canvas.drawPath(trianglePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}