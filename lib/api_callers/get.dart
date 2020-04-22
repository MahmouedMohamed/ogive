import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ogive/custom_widgets/marker_icon.dart';
import 'package:ogive/models/weather.dart';

final String URL = 'http://192.168.1.102:8000/api/Markers';

Future<List<Marker>> getMarkers() async {
  List data;
  MarkerIcon markerOption = new MarkerIcon();
  List<Marker> markers = new List<Marker>();
  var response = await http
      .get(Uri.encodeFull(URL), headers: {"Accpet": "application/json"});
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
