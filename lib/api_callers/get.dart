import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ogive/custom_widgets/marker_icon.dart';
import 'package:ogive/models/user.dart';
import 'package:ogive/models/weather.dart';

final String URL = 'http://192.168.1.103:8000/api/';
Future<List<Marker>> getMarkers() async {
  List data;
  MarkerIcon markerOption = new MarkerIcon();
  List<Marker> markers = new List<Marker>();
  var response = await http
      .get(Uri.encodeFull(URL+'Markers'), headers: {"Accpet": "application/json"});
  var convertDataToJson = jsonDecode(response.body);
  data = convertDataToJson['markers'];
  for (int i = 0; i < data.length; i++) {
    MarkerId markerId = new MarkerId(data[i]['id'].toString());
    double latitude = double.parse(data[i]['Latitude'].toString());
    double longitude = double.parse(data[i]['Longitude'].toString());
    markers.add(Marker(
      markerId: markerId,
      position: LatLng(latitude, longitude),
      icon: markerOption.getIcon(),
      infoWindow:
          InfoWindow(title: markerId.toString(), snippet: markerId.toString()),
    ));
  }
  return markers;
}
Future<Weather> getWeatherCondition(latitude,longitude) async{
  final String weatherURL = 'http://api.openweathermap.org/data/2.5/weather?lat='
  +latitude.toString()+"&lon="+longitude.toString()+"&appid="+'eeb0971ab03a92f6318c8907c2c13e20';
  var headers = {
    "Accpet": "application/json",
    "Content-Type": "application/json"
  };
  Weather weather;
  var response = await http
      .get(Uri.encodeFull(weatherURL), headers: headers);
  var convertDataToJson = jsonDecode(response.body);
  weather = new Weather(
    latitude,
    longitude,
    convertDataToJson['weather'][0]['main'].toString().toLowerCase(),
    double.parse(convertDataToJson['main']['temp'].toString())-273.15,
    double.parse(convertDataToJson['main']['temp_min'].toString())-273.15,
    double.parse(convertDataToJson['main']['temp_max'].toString())-273.15,
    double.parse(convertDataToJson['main']['pressure'].toString()),
    double.parse(convertDataToJson['main']['humidity'].toString())/100,
    double.parse(convertDataToJson['wind']['speed'].toString()),
  );
  return weather;
}
Future<Map<String,dynamic>> getUser(email,password) async {
  var body = {'email': email, 'password': password};
  var response = await http
      .post(Uri.encodeFull(URL+'login'), headers: {"Accpet": "application/json"},body: body);
  if(response.statusCode != 200){
    return null;
  }
  else{
    var convertDataToJson = jsonDecode(response.body);
    User user = new User(
      convertDataToJson['user']['id'].toString(),
      convertDataToJson['user']['name'],
      convertDataToJson['user']['user_name'],
      convertDataToJson['user']['email'],
      convertDataToJson['user']['email_verified_at'] == null ? null : DateTime.parse(convertDataToJson['user']['email_verified_at']),
      DateTime.parse(convertDataToJson['user']['created_at']),
      DateTime.parse(convertDataToJson['user']['updated_at']),
    );
    Map<String,dynamic> map = {"oauthToken": convertDataToJson['token'],"user" : user};
    print('thing  $map');
    return map;
  }
}