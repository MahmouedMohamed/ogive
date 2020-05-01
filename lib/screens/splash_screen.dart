import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => new _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation<Color> _colorAnimation;
  double x =0.0;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this,duration: Duration(seconds: 3));
    _colorAnimation = Tween<Color>(begin: Colors.green,end: Colors.blue).animate(_animationController);
  }
  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(x<1.0){
      setState(() {
        x+=0.01;
      });
      }
    });

    print(x);
    return Material(
      animationDuration: Duration(seconds: 3),
      child: AnimatedContainer(
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 40,left: 40),
        duration: Duration(seconds: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
                value: x,
                valueColor: _colorAnimation,
                backgroundColor: Colors.black,
              ),
          ],
        )
      ),
    );
  }
}
