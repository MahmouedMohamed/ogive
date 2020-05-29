import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
import 'package:ogive/custom_widgets/memory_wall.dart';
import 'package:ogive/custom_widgets/foodometer.dart';
import '../session_manager.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  SessionManager sessionManager;
  AnimationController _controller;
//  Animation _animation;
  double opacity = 1.0;
  int _selectedIndex = 1;
  int currentPage = 0;
  final pageOption = ["StayInTouch", "Home", "ReportProblem"];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.popAndPushNamed(context, pageOption[_selectedIndex]);
    });
  }

  @override
  void initState() {
    super.initState();
    sessionManager = new SessionManager();
    print('thing User is ${sessionManager.getUser().toList()}');
    initializeNotification();
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

  appBarColorSelector(pageNumber) {
    switch (pageNumber) {
      case 0:
        {
          return Colors.blue[900];
        }
        break;
      case 1:
        {
          return Colors.black;
        }
        break;
      case 2:
        {
          return Colors.black;
        }
        break;
      case 3:
        {
          return Colors.amber;
        }
        break;
      case 4:
        {
          return Colors.green;
        }
        break;
      case 5:
        {
          return Colors.yellow;
        }
        break;
      case 6:
        {
          return Colors.orange;
        }
        break;
      case 7:
        {
          return Colors.pink;
        }
        break;
      case 8:
        {
          return Colors.black;
        }
        break;
      case 9:
        {
          return Colors.teal;
        }
        break;
      case 10:
        {
          return Colors.blue;
        }
        break;
      default:
        {
          return Colors.black;
        }
        break;
    }
  }

  iconsColorSelector(pageNumber) {
    switch (pageNumber) {
      case 0:
        {
          return Colors.pink[400];
        }
        break;
      case 1:
        {
          return Colors.purple[900];
        }
        break;
      case 2:
        {
          return Colors.white;
        }
        break;
      case 3:
        {
          return Colors.red[900];
        }
        break;
      case 4:
        {
          return Colors.green[900];
        }
        break;
      case 5:
        {
          return Colors.yellow[900];
        }
        break;
      case 6:
        {
          return Colors.orange[900];
        }
        break;
      case 7:
        {
          return Colors.pink[900];
        }
        break;
      case 8:
        {
          return Colors.white;
        }
        break;
      case 9:
        {
          return Colors.teal[900];
        }
        break;
      case 10:
        {
          return Colors.blue[900];
        }
        break;
      default:
        {
          return Colors.white;
        }
        break;
    }
  }

  initializeNotification() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) {
        if(payload == 'W|B'){
          return Navigator.popAndPushNamed(context, 'UserDecision');
        }
        return null;
      }, );
  }

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setEnabledSystemUIOverlays([]);
//    _controller.forward();
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, "Bot");
      },
        child: Icon(Icons.message,color: iconsColorSelector(currentPage),size: 30,),
      backgroundColor: appBarColorSelector(currentPage),
        heroTag: "bot",
        tooltip: 'Bot',
      ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            backgroundColor: appBarColorSelector(currentPage),
            title: Text(
              'Welcome, ${sessionManager.getUser().user_name} !',
              overflow: TextOverflow.visible,
            ),
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: IconButton(icon: Icon(Icons.person,
                  size: 30, color: iconsColorSelector(currentPage)),
                onPressed: () {
                  Navigator.pushNamed(context, "Profile");
                },
              )
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings_applications),
                onPressed: () {
                  Navigator.pushNamed(context, 'UserDecision');
                },
              ),
//              Padding(
//                  padding: EdgeInsets.only(right: 10),
//                  child:
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  sessionManager.logout();
                  Navigator.of(context).popAndPushNamed('Login');
                },
              )
//    ),
            ],
//        primary: true,
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.people), title: Text('Stay in touch')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text('Home')),
//          BottomNavigationBarItem(
//              icon: Icon(
//                Icons.email,
//              ),
//              title: Text(
//                'Contact Us',
//              ))
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: iconsColorSelector(currentPage),
        onTap: _onItemTapped,
        backgroundColor: appBarColorSelector(currentPage),
      ),
      body: Builder(
        builder: (context) => LiquidSwipe(
          enableLoop: true,
          fullTransitionValue: 800,
          enableSlideIcon: true,
          waveType: WaveType.liquidReveal,
          positionSlideIcon: 0.0,
          onPageChangeCallback: (activePageIndex) {
            currentPage = activePageIndex;
          },
          pages: <Container>[
            FeedMeWidget(context, opacity),
            WhiteOrBlackWidget(context, opacity),
            MemoryWallWidget(context,opacity),
            Foodometer(context,opacity),
            MakeMeBreathWidget(context, opacity),
            BreedMeWidget(context, opacity),
            PayForMeWidget(context, opacity),
            FindMeJobWidget(context, opacity),
            PaintForMeWidget(context, opacity),
            HelpMeWidget(context, opacity),
            ChatWithMeWidget(context, opacity),
          ],
        ),
      ),
    );
  }
}
