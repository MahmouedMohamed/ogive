//import 'dart:async';
//import 'dart:io';
//import 'dart:math' as math;
//import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart' show rootBundle;
//import 'package:stats/stats.dart';
//
//import 'api_callers/get.dart';
//import 'ml_models/weather_model.dart';
//import 'models/user_location.dart';
//import 'models/weather.dart';
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      debugShowCheckedModeBanner: false,
//      home: HomePage(),
//      routes: <String, WidgetBuilder>{
////        "FeedMeIntro": (BuildContext context) => FeedMeIntro(),
////        "FeedMe": (BuildContext context) => FeedMe(),
//        //add more routes here
//      },
//    );
//  }
//}
//
//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  final fb = FirebaseDatabase.instance;
//  final myController = TextEditingController();
//  final name = "Markers";
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final ref = fb.reference();
//    List<dynamic> retrieved= new List<dynamic>();
//
//    return Scaffold(
//        appBar: AppBar(
//          title: Text(''),
//        ),
//        body: Container(
//            child: Column(
//          children: <Widget>[
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Text(name),
//                Flexible(child: TextField(controller: myController)),
//              ],
//            ),
//            RaisedButton(
//              onPressed: () {
//                ref.child(name).set(myController.text);
//              },
//              child: Text("Submit"),
//            ),
//            RaisedButton(
//              onPressed: () async {
//                List<dynamic> needs=new List<dynamic>();
//                await ref.child("Markers").once().then((value) {
//                  Map<dynamic,dynamic> map = value.value;
//                  print(map.keys);
//                  print(value.value['3']);
//                  for(int i=0;i<map.keys.length;i++){
////                    markers.add(Marker(
////                      markerId:
//                      print(map.keys.toList().elementAt(i));
////                      position: LatLng(
//                          print(map.values.toList().elementAt(i)['Latitude']);
////                  ,
//                    print(map.values.toList().elementAt(i)['Longitude']);
////                  ),
////                      icon: markerOption.getIcon(),
////                      infoWindow:
////                      InfoWindow(title: markerId.toString(), snippet: markerId.toString()),
////                    ));
//                    print(map.values.toList());
////                    value.value[i]['Latitude'] == null? 0 : needs.add(value.value[i]['Latitude']);
//                  }
//                });
//                print(needs);
////                markers.add(Marker(
////                  markerId: markerId,
////                  position: LatLng(latitude, longitude),
////                  icon: markerOption.getIcon(),
////                  infoWindow:
////                  InfoWindow(title: markerId.toString(), snippet: markerId.toString()),
////                ));
////                thing.then((value) => needs.add(value));
////                values.forEach((key, values) {
////                  needs.add(values);
////                });
////                print(needs);
////                    .once().then((DataSnapshot data) {
////                  print(data.toString().split(',').elementAt(0));
////                  print(data.value);
////                  print(data.key);
//                setState(() {
////                    retrieved.add(data.value);
//                });
////              },
//              },
//              child: Text("Get"),
//            ),
//            Text(retrieved.length == 0 ? '' : retrieved.elementAt(0).toString()),
//          ],
//        )));
//  }
//
//  @override
//  void dispose() {
//    // Clean up the controller when the widget is disposed.
//    myController.dispose();
//    super.dispose();
//  }
//}
