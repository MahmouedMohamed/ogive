import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ogive/api_callers/get.dart';
import 'package:ogive/ml_models/weather_model.dart';
import 'package:ogive/models/user_location.dart';
import 'package:ogive/models/weather.dart';

class WhiteOrBlack extends StatefulWidget {
  @override
  _WhiteOrBlackState createState() => _WhiteOrBlackState();
}

class _WhiteOrBlackState extends State<WhiteOrBlack> {
  Weather weather;
  UserLocation userLocation;
  @override
  void initState() {
    super.initState();
    userLocation= new UserLocation();
  }
  Future<String> get() async {
    if (userLocation.getLatLng() == null) {
      await userLocation.getUserLocation();
    }
    weather = await getWeatherCondition(userLocation.getLatLng().latitude,userLocation.getLatLng().longitude);
    Model model = new Model();
    return model.test(weather.getCondition,weather.getTemperature,weather.getHumidity,weather.getWindSpeed);
  }
  Widget showResult() {
    return FutureBuilder<String>(
      future: get(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Text(snapshot.data);
        } else if (snapshot.error != null) {
          return Container(
            alignment: Alignment.center,
            child: Text(
                '${snapshot.error}'),
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
  @override
  Widget build(BuildContext context) {
    return showResult();
  }
}
