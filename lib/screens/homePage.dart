import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:ogive/custom_widgets/breed_me.dart';
import 'package:ogive/custom_widgets/chat_with_me.dart';
import 'package:ogive/custom_widgets/feed_me.dart';
import 'package:ogive/custom_widgets/find_me_a_job.dart';
import 'package:ogive/custom_widgets/help_me.dart';
import 'package:ogive/custom_widgets/make_me_breath.dart';
import 'package:ogive/custom_widgets/paint_for_me.dart';
import 'package:ogive/custom_widgets/pay_for_me.dart';
import 'package:ogive/custom_widgets/white_or_black.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
//  Animation _animation;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    changeOpacity();
//    _controller = AnimationController(vsync: this,duration: Duration(seconds: 2),reverseDuration: Duration(seconds: 2));
//    _animation = Tween(begin: 0.0,end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
//    _controller.dispose();
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
        changeOpacity();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
//    _controller.forward();
    return Scaffold(
      body: Builder(
        builder: (context) => LiquidSwipe(
          enableLoop: true,
          fullTransitionValue: 800,
          enableSlideIcon: true,
          waveType: WaveType.liquidReveal,
          positionSlideIcon: 0.8,
          pages: <Container>[
            FeedMeWidget(context,opacity),
            WhiteOrBlackWidget(context,opacity),
            MakeMeBreathWidget(context,opacity),
            BreedMeWidget(context,opacity),
            PayForMeWidget(context,opacity),
            FindMeJobWidget(context,opacity),
            PaintForMeWidget(context,opacity),
            HelpMeWidget(context,opacity),
            ChatWithMeWidget(context,opacity),
          ],
        ),
      ),
    );
  }
}
