import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ogive/custom_widgets/marker_icon.dart';
import 'package:ogive/models/like.dart';
import 'package:ogive/models/memory.dart';
import 'package:ogive/models/user.dart';
import 'package:ogive/models/weather.dart';
import 'package:dio/dio.dart';
final String URL = 'http://192.168.1.100:8000/api/';
Future<List<Marker>> getMarkers(String oauthToken) async {
  List markers;
//  List properties;
  MarkerIcon markerOption = new MarkerIcon();
  List<Marker> returnedMarkers = new List<Marker>();
  var response = await http.get(Uri.encodeFull(URL + 'markers'),
      headers: {"Accpet": "application/json","Authorization": "Bearer "+oauthToken});
  print('thing ${response.body}');
  var convertDataToJson = jsonDecode(response.body);
  print('thing $convertDataToJson');
  markers = convertDataToJson['markers'];
  print('thing $markers');
//  properties = convertDataToJson['properties'];
  for (int i = 0; i < markers.length; i++) {
    MarkerId markerId = new MarkerId(markers[i]['id'].toString());
    double latitude = double.parse(markers[i]['Latitude'].toString());
    double longitude = double.parse(markers[i]['Longitude'].toString());
    returnedMarkers.add(Marker(
      markerId: markerId,
      position: LatLng(latitude, longitude),
//      icon: markerOption.getIcon(),
      icon: getMarkerColor(markers[i]['food']['priority']),
      infoWindow: InfoWindow(
          title: markers[i]['food']['name'],
          snippet: markers[i]['food']['description'] +
              ' \nQuantity = ${markers[i]['food']['quantity']}'),
    ));
  }
  return returnedMarkers;
}

getMarkerColor(priority) {
  switch (priority) {
    case 1:
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    case 4:
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    case 5:
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  }
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
    convertDataToJson['name'].toString(),
    latitude,
    longitude,
    convertDataToJson['weather'][0]['main'].toString().toLowerCase(),
    convertDataToJson['weather'][0]['description'],
    double.parse(convertDataToJson['main']['temp'].toString()) - 273.15,
    double.parse(convertDataToJson['main']['temp_min'].toString()) - 273.15,
    double.parse(convertDataToJson['main']['temp_max'].toString()) - 273.15,
    double.parse(convertDataToJson['main']['pressure'].toString()),
    double.parse(convertDataToJson['main']['humidity'].toString()),
    double.parse(convertDataToJson['wind']['speed'].toString()),
  );
  return weather;
}

Future<Map<String, dynamic>> getUser(email, password) async {
  var body = {'email': email, 'password': password};
  var response = await http.post(Uri.encodeFull(URL + 'login'),
      headers: {"Accpet": "application/json"}, body: body);
  if (response.statusCode != 200) {
    return null;
  } else {
    var convertDataToJson = jsonDecode(response.body);
    User user = new User(
      convertDataToJson['user']['id'].toString(),
      convertDataToJson['user']['name'],
      convertDataToJson['user']['user_name'],
      convertDataToJson['user']['email'],
      convertDataToJson['user']['email_verified_at'] == null
          ? null
          : DateTime.parse(convertDataToJson['user']['email_verified_at']),
      DateTime.parse(convertDataToJson['user']['created_at']),
      DateTime.parse(convertDataToJson['user']['updated_at']),
    );
    Map<String, dynamic> map = {
      "oauthToken": convertDataToJson['token'],
      "user": user
    };
    print('thing  $map');
    return map;
  }
}

Future<List<Memory>> getMemories(String oauthToken) async {
  List returnedMemories = new List<Memory>();
  var response = await http.get(Uri.encodeFull(URL + 'memories'),
      headers: {"Accpet": "application/json","Authorization": "Bearer "+oauthToken});
  var convertDataToJson = jsonDecode(response.body);
  List memories = convertDataToJson['memories'];
  print('thing $memories');
  for (int i = 0; i < memories.length; i++) {
    List returnedLikes = new List<Like>();
    if(memories[i]['likes']!=null){
      List likes = memories[i]['likes'];
      for (int j = 0; j < likes.length; j++) {
        returnedLikes.add(new Like(
          likes[j]['memory_id'].toString(),
          likes[j]['user_id'].toString(),
        ));
      }
    }
    returnedMemories.add(
      new Memory(
          memories[i]['id'].toString(),
          memories[i]['user_id'].toString(),
          memories[i]['person_name'].toString(),
          DateTime.parse(memories[i]['birth']),
          DateTime.parse(memories[i]['death']),
          memories[i]['life_story'].toString(),
          memories[i]['image'].toString(),
          returnedLikes),
    );
  }
  return returnedMemories;
}
Future<Map<String,dynamic>> getJob() async {
  var response = await http.get(Uri.encodeFull('https://remotive.io/api/remote-jobs?limit=100'),
      headers: {"Accpet": "application/json"});
  var convertDataToJson = jsonDecode(response.body);
//  print('thing ${convertDataToJson['jobs'].length}');
  return convertDataToJson;
}
Future<String> getQuote() async {
  var response = await http.get(Uri.encodeFull('https://api.fisenko.net/quotes?l=en'),
      headers: {"Accpet": "application/json"});
  var convertDataToJson = jsonDecode(response.body);
  print('thing ${convertDataToJson['text']}');
  return convertDataToJson['text'];
}
Future<Map<String,dynamic>> getNews(query,pageNumber) async {
  var response = await http.get(Uri.encodeFull('http://content.guardianapis.com/world/$query?api-key=7bd910b5-889e-4446-904d-dae19d3890bc&page=$pageNumber'),
      headers: {"Accpet": "application/json"});
  var convertDataToJson = jsonDecode(response.body);
  return convertDataToJson;
}
Future<String> getSpaceNews() async {
  var response = await http.get(Uri.encodeFull('https://api.spacexdata.com/v3/launches/latest'),
      headers: {"Accpet": "application/json"});
  var convertDataToJson = jsonDecode(response.body);
  print('thing ${convertDataToJson}');
//  return convertDataToJson['text'];
}