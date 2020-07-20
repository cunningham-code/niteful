import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'user.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_auth/local_auth.dart';

var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

class Storage {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user0.txt');
  }

  // * #############################################
  // * #############################################
  // * #############################################

  Future<String> readFileString() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "";
    }
  }

  Future<File> writeToFile(String s) async {
    final file = await _localFile;

    return file.writeAsString('$s');
  }

  // * #############################################
  // * #############################################
  // * #############################################

  // ? Appreciations
  // ? #############################################

  Future<List<String>> getThoughts() async {
    User u = await getUser();
    return u.getThoughts();
  }

  Future<bool> addThought(String s) async {
    User u = await getUser();
    bool b = u.addThought(s);
    writeUser(u);
    return b;
  }

  Future<bool> eraseThoughts() async {
    User u = await getUser();
    bool b = u.eraseThoughts();
    writeUser(u);
    return b;
  }

  Future<bool> disableThoughts() async {
    User u = await getUser();
    bool b = u.disableThoughts();
    writeUser(u);
    return b;
  }

  // ? Morning Message
  // ? #############################################

  Future<List<String>> getMornings() async {
    User u = await getUser();
    return u.getMornings();
  }

  Future<String> addMorningMessage(String s) async {
    User u = await getUser();
    u.addMorningMessage(s);
    writeUser(u);
    return s;
  }

  Future<bool> eraseMorning() async {
    User u = await getUser();
    bool b = u.eraseMorning();
    writeUser(u);
    return b;
  }

  Future<bool> disableMorning() async {
    User u = await getUser();
    bool b = u.disableMorning();
    writeUser(u);
    return b;
  }

  // ? Daily Value
  // ? #############################################

  Future<List<int>> getDailyValues() async {
    User u = await getUser();
    return u.getDailyValues();
  }

  Future<bool> addDailyValue(int i) async {
    User u = await getUser();
    bool b = u.addDailyValue(i);
    writeUser(u);
    return b;
  }

  Future<bool> eraseDailyValues() async {
    User u = await getUser();
    bool b = u.eraseDailyValues();
    writeUser(u);
    return b;
  }

  Future<bool> disableDailyValues() async {
    User u = await getUser();
    bool b = u.disableDailyValues();
    writeUser(u);
    return b;
  }

    // ? Morning Message
  // ? #############################################

  Future<List<String>> getInsights() async {
    User u = await getUser();
    return u.getInsights();
  }

  Future<String> addInsights(String s) async {
    print("ADD INSIGHTS: " + s);
    User u = await getUser();
    u.addInsights(s);
    writeUser(u);
    return s;
  }

  Future<bool> eraseInsights() async {
    User u = await getUser();
    bool b = u.eraseInsights();
    writeUser(u);
    return b;
  }

  Future<bool> disableInsights() async {
    User u = await getUser();
    bool b = u.disableInsights();
    writeUser(u);
    return b;
  }

  // ? Misc
  // ? #############################################

  void createUser() {
    User u = User.newUser();
    writeUser(u);
  }

  Future<User> getUser() async {
    String s = await readFileString();
    if((s == null)||(s.length <= 1)) {
      createUser();
    }
    Map userMap = jsonDecode(s);
    User u = new User.fromJson(userMap);
    if(u.version != "1.0.2") {
      print("TRANSFERING USER DATA");
      User newu = User.newUser();
      newu.thoughts = u.thoughts ?? "";
      newu.morningMessages = u.morningMessages ?? "";
      newu.dailyValues = u.dailyValues ?? "";
      newu.name = u.name ?? "";
      newu.insights = u.insights ?? "";
      writeUser(newu);
      return newu;
    }
    return u;
  }

  Future<bool> writeUser(User u) async {
    String s = jsonEncode(u);
    print("WRITE USER " + s);
    checkSettings();
    writeToFile(s);
    return true;
  }

  Future<String> setName(String s) async {
    User u = await getUser();
    u.setName(s);
    writeUser(u);
    return s;
  }

  void checkSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SETTINGS " + prefs.getKeys().toString());
  }

  checkNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("notifications");
  }

  Future<String> getTextFromFile(String shour, String sminute) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int h = prefs.getInt(shour);
    int m = prefs.getInt(sminute);

    if((h != null)||(m != null)) {
      return h.toString() + "h | " + m.toString() + "m";
    }
    return "Turn notifcations on.";
  }

 Future<bool> setMorningNotificationTime(TimeOfDay t) async {
    if(t != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      print("THOUR: " + t.hour.toString());
      print("TMINUTE: " + t.minute.toString());

      prefs.setInt("morningHour", t.hour);
      prefs.setInt("morningMinute", t.minute);
    }
    return true;
  }

  Future<bool> setInsightReaction() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setBool("insightReacted", true);
  }

  Future<bool> getInsightReaction() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool("insightReacted");
  }

  Future showMorningNotification(String pload) async {

      if(pload == null) {
        print("NOT SETTING MORNING NOTIFICATION: NULL");
        return;
      }

      if(pload.length < 1) {
        print("NOT SETTING MORNING NOTIFICATION: EMPTY");
        return;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      int h = prefs.getInt("morningHour") ?? 8;
      int m = prefs.getInt("morningMinute") ?? 0;

      print("MORNING NOTIFICATION " + pload + " @ HOUR: " + h.toString() + " + MINUTE: " + m.toString());
    
      var cday = new DateTime.now();
      var nday = cday.add(new Duration(days: 1));

      var inputday = new DateTime(cday.year, cday.month, cday.day, h, m);

      var scheduledNotificationDateTime;

      if(cday.isBefore(inputday)) {
        print("SENDING MESSAGE TODAY");
        scheduledNotificationDateTime = inputday;
      } else {
        print("SENDING MESSAGE TOMORROW");
        scheduledNotificationDateTime = new DateTime(nday.year, nday.month, nday.day, h, m);
      }
    

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'morning-messages',
        'Morning Messages',
        'These are messages people set for themselves in the morning.');
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        1,
        'Good Morning!',
        pload,
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        payload: "M:" + pload);
  }

 Future<bool> setNightNotificationTime(TimeOfDay t) async {
    if(t != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      print("THOUR: " + t.hour.toString());
      print("TMINUTE: " + t.minute.toString());

      prefs.setInt("nightHour", t.hour);
      prefs.setInt("nightMinute", t.minute);
    }
    scheduleNightNotification();
    return true;
  }

  Future<bool> setInsightNum(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SETTING IN:" + i.toString());
    prefs.setInt("insightNum", i);
    return true;
  }

  Future<int> getInsightNum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("GETTING IN:" + (prefs.getInt("insightNum") ?? -1).toString());
    return prefs.getInt("insightNum") ?? -1;
  }

  Future<bool> setBiometrics() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var localAuth = LocalAuthentication();
    bool didAuthenticate =
        await localAuth.authenticateWithBiometrics(
            localizedReason: 'Turn On Biometric Check');
    print(didAuthenticate);

    prefs.setBool("biometrics", didAuthenticate);
    return true;
  }

  Future scheduleNightNotification() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getInt("nightHour"));
    print(prefs.getInt("nightMinute"));
    int h = prefs.getInt("nightHour") ?? 22;
    int m = prefs.getInt("nightMinute") ?? 0;

    var time = new Time(h, m, 0);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        "Let's wrap up your day.",
        "Here are a few questions for you.",
        time,
        platformChannelSpecifics,
        payload: "N:ERROR");
  }
}


