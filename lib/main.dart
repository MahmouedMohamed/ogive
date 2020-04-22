import 'package:flutter/material.dart';
import 'package:ogive/screens/feed_me_main.dart';
import 'screens/feed_me_intro.dart';
import 'screens/homePage.dart';
import 'screens/white_or_black_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "FeedMeIntro": (BuildContext context) => FeedMeIntro(),
        "FeedMe": (BuildContext context) => FeedMe(),
        "WhiteOrBlack": (BuildContext context) => WhiteOrBlack(),
        //add more routes here
      },
    );
  }
}
