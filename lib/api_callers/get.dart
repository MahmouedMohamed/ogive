import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ogive/custom_widgets/marker_icon.dart';
import 'package:ogive/models/user.dart';
import 'package:ogive/models/weather.dart';

final fb = FirebaseDatabase.instance;
Future<List<Marker>> getMarkers() async {
  final ref = fb.reference();
  List<Marker> markers = new List<Marker>();
  MarkerIcon markerOption = new MarkerIcon();
  await ref.child('Markers').orderByKey().once().then((value) {
    Map<dynamic, dynamic> map = value.value;
    for (int i = 0; i < map.keys.length; i++) {
      MarkerId markerId =
          new MarkerId(map.keys.toList().elementAt(i).toString());
      double latitude =
          double.parse(map.values.toList().elementAt(i)['Latitude'].toString());
      double longitude = double.parse(
          map.values.toList().elementAt(i)['Longitude'].toString());
      markers.add(Marker(
        markerId: markerId,
        position: LatLng(latitude, longitude),
        icon: markerOption.getIcon(),
        infoWindow: InfoWindow(
            title: markerId.toString(), snippet: markerId.toString()),
      ));
    }
  });
  print('thing $markers');
  return markers;
}

Future<Weather> getWeatherCondition(latitude, longitude) async {
  final String weatherURL =
      'http://api.openweathermap.org/data/2.5/weather?lat=' +
          latitude.toString() +
          "&lon=" +
          longitude.toString() +
          "&appid=" +
          'eeb0971ab03a92f6318c8907c2c13e20';
  var headers = {
    "Accpet": "application/json",
    "Content-Type": "application/json"
  };
  Weather weather;
  var response = await http.get(Uri.encodeFull(weatherURL), headers: headers);
  var convertDataToJson = jsonDecode(response.body);
  weather = new Weather(
    latitude,
    longitude,
    convertDataToJson['weather'][0]['main'].toString().toLowerCase(),
    double.parse(convertDataToJson['main']['temp'].toString()) - 273.15,
    double.parse(convertDataToJson['main']['temp_min'].toString()) - 273.15,
    double.parse(convertDataToJson['main']['temp_max'].toString()) - 273.15,
    double.parse(convertDataToJson['main']['pressure'].toString()),
    double.parse(convertDataToJson['main']['humidity'].toString()) / 100,
    double.parse(convertDataToJson['wind']['speed'].toString()),
  );
  return weather;
}

Future<User> getUser(userId) async {
  final ref = fb.reference();
  User user;
  await ref.child('Users').child('$userId').once().then((value) {
    Map<dynamic, dynamic> map = value.value;
    print('thing ${map['name']}');
    user = new User(
      userId,
      map['name'],
      map['email'],
      DateTime.parse(map['created_at']),
    );
    print('thing good ${user.getName()}');
  });
  return user;
}
