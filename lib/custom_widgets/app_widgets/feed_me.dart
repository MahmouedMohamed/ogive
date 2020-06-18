import 'package:flutter/material.dart';

Widget feedMeWidget(BuildContext context, double opacity) {
  return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blue[900],
        Colors.blue[800],
        Colors.blue[700],
        Colors.blue[600],
        Colors.blue[500],
        Colors.blue[400],
        Colors.blue[300],
        Colors.blue[200],
        Colors.blue[100],
        Colors.white
      ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'FeedMeIntro');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/10, bottom: 20),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Feed Me',
                  style: TextStyle(
                    color: Colors.pink[500],
                    fontSize: 70,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.4,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset.fromDirection(1, 3))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 30),
              child: Image.asset(
                'assets/images/food.png',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Feed Me is a program that helps you to save people from starving by sharing your food with them.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: AnimatedOpacity(
                  opacity: opacity == 1 ? 0 : 1,
                  duration: Duration(seconds: 2),
                  child: Text('Click to Proceed')),
            )
          ],
        ),
      ));
}
