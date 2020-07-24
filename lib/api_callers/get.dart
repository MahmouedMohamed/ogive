import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ogive/factoryCreator/ObjectFactory.dart';
import 'package:ogive/models/memory.dart';
import 'package:ogive/models/weather.dart';

final String URL = 'http://192.168.1.11:8000/api/';
ObjectFactory factory = new ObjectFactory();

Future<List<Marker>> getMarkers(String oauthToken) async {
  var response = await http.get(Uri.encodeFull(URL + 'markers'),
      headers: {"Accpet": "application/json","Authorization": "Bearer "+oauthToken});
  var convertDataToJson = jsonDecode(response.body);
  return factory.getMarkersFromJson(convertDataToJson);
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
  var response = await http.get(Uri.encodeFull(weatherURL), headers: headers);
  var convertDataToJson = jsonDecode(response.body);
  return factory.getWeatherFromJson(convertDataToJson,latitude, longitude);
}

Future<Map<String, dynamic>> getUser(email, password) async {
  var body = {'email': email, 'password': password};
  var response = await http.post(Uri.encodeFull(URL + 'login'),
      headers: {"Accpet": "application/json"}, body: body);
  if (response.statusCode != 200) {
    return null;
  } else {
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson['error']==null?
    {
      "oauthToken": convertDataToJson['token'],
      "user": factory.getUserFromJson(convertDataToJson)
    }: null;
  }
}

Future<List<Memory>> getMemories(String oauthToken) async {
  var response = await http.get(Uri.encodeFull(URL + 'memories'),
      headers: {"Accpet": "application/json","Authorization": "Bearer "+oauthToken});
  var convertDataToJson = jsonDecode(response.body);
  return factory.getMemoriesFromJson(convertDataToJson);
}

Future<Map<String,dynamic>> getJob() async {
  var response = await http.get(Uri.encodeFull('https://remotive.io/api/remote-jobs?limit=100'),
      headers: {"Accpet": "application/json"});
  var convertDataToJson = jsonDecode(response.body);
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