import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ogive/custom_widgets/marker_icon.dart';

final String url = 'http://192.168.1.102:8000/api/Markers';

Future<List<Marker>> getMarkers() async {
  List data;
  MarkerIcon markerOption = new MarkerIcon();
  List<Marker> markers = new List<Marker>();
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accpet": "application/json"});
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
