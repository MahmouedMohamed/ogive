import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ogive/screens/feed_me/feed_me_main.dart';
import 'package:ogive/test.dart';
import 'package:ogive/screens/white_or_black/user_decision.dart';
import 'package:ogive/screens/feed_me/feed_me_intro.dart';
import 'package:ogive/screens/feed_me/feed_me_marker_creation.dart';
import 'screens/homePage.dart';
import 'package:ogive/screens/registering/login_screen.dart';
import 'package:ogive/screens/registering/signup_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/stay_in_touch_page.dart';
import 'package:ogive/screens/white_or_black/white_or_black_main.dart';
import 'screens/profile_page.dart';
import 'package:ogive/screens/memory_wall/memory_wall.dart';
import 'package:ogive/screens/memory_wall/memory_wall_memory_creation.dart';
import 'screens/bot.dart';
void main() {
  runApp(Ogive());
}

class Ogive extends StatefulWidget {
  @override
  _OgiveState createState() => _OgiveState();
}
class _OgiveState extends State<Ogive> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Ogive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        "SplashScreen": (BuildContext context) => SplashScreen(),
        "Login": (BuildContext context) => LoginScreen(),
        "Signup": (BuildContext context) => SignupScreen(),
        "Home": (BuildContext context) => HomePage(),
        "Profile": (BuildContext context) => ProfilePage(),
//        "ReportProblem": (BuildContext context) => ReportProblemPage(),
        "StayInTouch": (BuildContext context) => StayInTouchPage(),
        "FeedMeIntro": (BuildContext context) => FeedMeIntro(),
        "FeedMe": (BuildContext context) => FeedMe(),
        "MarkerCreation" : (BuildContext context) => MarkerCreation(),
        "MemoryCreation" : (BuildContext context) => MemoryCreation(),
        "WhiteOrBlack": (BuildContext context) => WhiteOrBlack(),
        "UserDecision": (BuildContext context) => UserDecision(),
        "MemoryWall": (BuildContext context) => MemoryWall(),
        "Bot" : (BuildContext context) => Bot(),
        "Test" : (BuildContext context) => Test(),
        //add more routes here
      },
    );
  }
}
