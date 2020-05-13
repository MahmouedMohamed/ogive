import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ogive/screens/feed_me_main.dart';
import 'custom_widgets/user_decision.dart';
import 'screens/feed_me_intro.dart';
import 'screens/feed_me_marker_creation.dart';
import 'screens/homePage.dart';
import 'screens/login_screen.dart';
import 'screens/report_a_problem_page.dart';
import 'screens/signup_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/stay_in_touch_page.dart';
import 'screens/white_or_black_main.dart';

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
//        "ReportProblem": (BuildContext context) => ReportProblemPage(),
        "StayInTouch": (BuildContext context) => StayInTouchPage(),
        "FeedMeIntro": (BuildContext context) => FeedMeIntro(),
        "FeedMe": (BuildContext context) => FeedMe(),
        "MarkerCreation" : (BuildContext context) => MarkerCreation(),
        "WhiteOrBlack": (BuildContext context) => WhiteOrBlack(),
        "UserDecision": (BuildContext context) => UserDecision(),
        //add more routes here
      },
    );
  }
}
