import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ogive/api_callers/get.dart';
import 'package:ogive/custom_widgets/text.dart';
import 'package:ogive/ml_models/weather_model.dart';
import 'package:ogive/models/user_location.dart';
import 'package:ogive/models/weather.dart';
import '../session_manager.dart';
import 'homePage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
class WhiteOrBlack extends StatefulWidget {

  @override
  _WhiteOrBlackState createState() => _WhiteOrBlackState();
}
enum TtsState { playing, stopped }
class _WhiteOrBlackState extends State<WhiteOrBlack> {
  Weather weather;
  UserLocation userLocation;
  SessionManager sessionManager = new SessionManager();
  FlutterTts flutterTts;
  @override
  void initState() {
    super.initState();
    userLocation = new UserLocation();
    initTts();
  }
  initTts() {
    flutterTts = FlutterTts();
  }
  Future _speak(_newVoiceText) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.65);
    await flutterTts.setPitch(1.1);
    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        await flutterTts.speak(_newVoiceText);
      }
    }
  }

  Future<Map<String, dynamic>> get() async {
    if (userLocation.getLatLng() == null) {
      await userLocation.getUserLocation();
    }
    weather = await getWeatherCondition(
        userLocation.getLatLng().latitude, userLocation.getLatLng().longitude);
    Model model = new Model();
    return {
      'model': model.test(weather.getCondition.toString().toLowerCase(),
          weather.getTemperature, weather.getHumidity, weather.getWindSpeed)=='yes'? 'You can wear White!' : 'You can wear Black!' ,
      'weather': weather
    };
  }

  Widget showResult() {
    return FutureBuilder<Map<String, dynamic>>(
      future: get(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          if(sessionManager.weatherInfoExist()){
            sessionManager.clearWeatherInfo();
            print('thing hhh${snapshot.data}');
            sessionManager.createWeatherInfo(snapshot.data);
            _scheduleNotification();
          }
          else{
            print('thing hhh${snapshot.data}');
            sessionManager.createWeatherInfo(snapshot.data);
            _scheduleNotification();
          }
          return getBody(snapshot.data);
        } else if (snapshot.error != null) {
          sessionManager.clearWeatherInfo();
          return Container(
            alignment: Alignment.center,
            child: Text('${snapshot.error}'),
          );
        } else {
          return Container(
            color: Colors.black,
            alignment: Alignment.center,
            child: CupertinoActivityIndicator(
              animating: true,
              radius: 50,
            ),
          );
        }
      },
    );
  }
  Future _scheduleNotification() async {
    var scheduledNotificationDateTime =
    DateTime.now().add(new Duration(seconds: 5));
    var vibrationPattern = new Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '23', 'OGIVE', 'OGIVE Program',
        importance: Importance.Max, priority: Priority.High, ticker: 'OGIVE',
//        icon: 'ogive_version_2',
        vibrationPattern: vibrationPattern);
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        TimeOfDay.now().minute,
        'White Or Black',
        'tell us which type of clothes would suited today\'s weather?',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
    payload: 'W|B');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return showResult();
  }

  Widget getBody(Map<String, dynamic> data) {
    List<dynamic> decoration = getDecoration(
        data.values.elementAt(1).condition
        );
    _speak('Hey today temperature is '+data.values.elementAt(1).temperature.toString()+' So '+data.values.elementAt(0).toString());
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/${decoration.elementAt(0)}.png'),
            fit: BoxFit.cover),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.1),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 15,
              width: MediaQuery.of(context).size.width - 15,
              child: Container(
                height: MediaQuery.of(context).size.height - 20,
                width: MediaQuery.of(context).size.width - 20,
                padding: EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(
                      color: decoration[3],
                      width: 2,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    text('${data.values.elementAt(1).city}', decoration[3],
                        60.0, 1.5, FontWeight.w200),
                    text('${TimeOfDay.now().hour}:${TimeOfDay.now().minute}',
                        decoration[3], 40.0, 1.5, FontWeight.w100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Icon(
                          Icons.vertical_align_bottom,
                          size: 20,
                          color: decoration[3],
                        ),
                        text(
                            data.values.elementAt(1).tempMin.toStringAsFixed(0),
                            decoration[3],
                            40.0,
                            1.0,
                            FontWeight.w100),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          decoration[1],
                          color: decoration[2],
                          size: 40,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.vertical_align_top,
                          size: 20,
                          color: decoration[3],
                        ),
                        text(
                            data.values.elementAt(1).tempMax.toStringAsFixed(0),
                            decoration[3],
                            40.0,
                            1.0,
                            FontWeight.w100),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.15),
                      ),
                      child: Column(
                        children: [
                          text(data.values.elementAt(1).description,
                              decoration[3], 40.0, 1.0, FontWeight.w100),
                          Divider(
                            height: 1,
                            color: Colors.white.withOpacity(0.5),
                            indent: 10,
                            endIndent: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.wind,
                                color: Colors.blueGrey,
                                size: 30,
                              ),
                              text(
                                  data.values.elementAt(1).windSpeed.toString() + ' m/s',
                                  decoration[3],
                                  40.0,
                                  1.0,
                                  FontWeight.w100),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Colors.white.withOpacity(0.5),
                            indent: 10,
                            endIndent: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.compass,
                                color: Colors.red[800],
                                size: 30,
                              ),
                              text(
                                  data.values.elementAt(1).pressure.toString() +
                                      ' hPa',
                                  decoration[3],
                                  40.0,
                                  1.0,
                                  FontWeight.w100),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Colors.white.withOpacity(0.5),
                            indent: 10,
                            endIndent: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.opacity,
                                color: Colors.yellow[600],
                                size: 30,
                              ),
                              text(
                                  data.values.elementAt(1).humidity.toString() + ' %',
                                  decoration[3],
                                  40.0,
                                  1.0,
                                  FontWeight.w100),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(FontAwesomeIcons.magic,
                        color: Colors.blue[700], size: 30),
                    Text(
                      '${data.values.elementAt(0).toString()} !',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bilbo(
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400,
                          color: decoration[3],
                          fontSize: 70.0),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            text(
                                '${data.values.elementAt(1).temperature.toStringAsFixed(0)}',
                                decoration[3],
                                80.0,
                                1.0,
                                FontWeight.w200),
                            text('°C', decoration[3], 40.0, 1.0,
                                FontWeight.w200),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getDecoration(condition) {
    switch (condition) {
      case 'clear':
        return ['clear', FontAwesomeIcons.tree, Colors.green, Colors.white];
      case 'clouds':
        return ['clouds', FontAwesomeIcons.cloud, Colors.white, Colors.white];
      case 'drizzle':
        return [
          'drizzle',
          FontAwesomeIcons.cloudMoonRain,
          Colors.blue,
          Colors.white
        ];
      case 'rain':
        return ['rain', FontAwesomeIcons.cloudRain, Colors.blue, Colors.white];
      case 'snow':
        return ['snow', FontAwesomeIcons.snowplow, Colors.black, Colors.black];
      case 'Thunderstorm':
        return [
          'Thunderstorm',
          FontAwesomeIcons.pooStorm,
          Colors.deepPurple[700],
          Colors.white
        ];
      default:
        return ['sunny', Icons.wb_sunny, Colors.orange, Colors.black];
    }
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
}
