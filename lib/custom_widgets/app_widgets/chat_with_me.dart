import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

Widget chatWithMeWidget(BuildContext context, double opacity) {
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
                colors: [Colors.blue[900], Colors.white],
                begin: Alignment.topCenter, end: Alignment.bottomCenter
            )),
        child: GestureDetector(
            onTap: () {
//          Navigator.pushNamed(context, 'ChatWithMe');
              Toast.show('Coming Soon', context,duration: 3,backgroundColor: Colors.blue,gravity: 3);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/10, bottom: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(text: 'Chat With Me',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'OpenSans',
                            letterSpacing: 0,
                            color: Colors.blue[900],
                            shadows: [Shadow(color: Colors.black,offset: Offset.fromDirection(1,3))]
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/images/boy.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            )),
      ));
}
