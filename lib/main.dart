import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ogive/screens/feed_me_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'screens/feed_me_intro.dart';
import 'screens/homePage.dart';
import 'screens/login_screen.dart';
import 'screens/white_or_black_main.dart';
import 'session_manager.dart';

void main() {
  runApp(Ogive());
}

class Ogive extends StatefulWidget {
  @override
  _OgiveState createState() => _OgiveState();
}

class _OgiveState extends State<Ogive> {
  SessionManager sessionManager;
  bool isLogin;
  @override
  initState() {
    super.initState();
    sessionManager = new SessionManager();
    getSession();
  }

  getSession() async {
    await sessionManager.getSessionManager();
    setState(() {});
  }

  getHomePage() {
    if (sessionManager.isLoggin()) {
      sessionManager.loadSession();
      return HomePage();
    } else
      return LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: sessionManager.sharedPreferences == null
          ? Container(
              color: Colors.lightBlue,
              child: CupertinoActivityIndicator(
                radius: 40,
              ),
            )
          : getHomePage(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => LoginScreen(),
        "Home": (BuildContext context) => HomePage(),
        "FeedMeIntro": (BuildContext context) => FeedMeIntro(),
        "FeedMe": (BuildContext context) => FeedMe(),
        "WhiteOrBlack": (BuildContext context) => WhiteOrBlack(),
        //add more routes here
      },
    );
  }
}
