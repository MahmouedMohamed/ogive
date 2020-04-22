import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:toast/toast.dart';

Widget MakeMeBreathWidget(BuildContext context, double opacity) {
  return Container(
    color: Colors.grey,
    foregroundDecoration: BoxDecoration(
      color: Colors.black.withOpacity(0.7),
    ),
    child:
    Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.white],
              begin: Alignment.topCenter, end: Alignment.bottomCenter
          )),
      child: GestureDetector(
        onTap: () {
//          Navigator.pushNamed(context, 'MakeMeBreath');
        Toast.show('Coming Soon', context,duration: 3,backgroundColor: Colors.green,gravity: 3);
        },
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 10, bottom: 20),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/ogive_version_2.png',
                  scale: MediaQuery.of(context).size.height / 50,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 20),
              child: Align(
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(text: 'Make \n Me \n Breath',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'OpenSans',
                        letterSpacing: 0,
                        color: Colors.green[800],
                        shadows: [Shadow(color: Colors.black,offset: Offset.fromDirection(1,3))]
                      ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/images/tree.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        )),
      ));
}
