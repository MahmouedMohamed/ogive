import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ogive/custom_widgets/marker_icon.dart';

final String URL = 'http://192.168.1.103:8000/api/';
final fb = FirebaseDatabase.instance;
//Future<int> deleteMarker(markerId) async {
//  String url = URL + 'Marker';
//  String body = '{"id": "$markerId", "status": "0"}';
//  var headers = {
//    "Accpet": "application/json",
//    "Content-Type": "application/json"
//  };
//  var response = await http.put(Uri.encodeFull(url),headers: headers,body: body);
//  return response.statusCode;
//}
Future<int> deleteMarker(markerId) async {
  final ref = fb.reference();
  await ref.child("Markers").child(markerId.toString()).remove();
//  .once().then((value) {
//    Map<dynamic,dynamic> map = value.value;
//  String url = URL + 'Marker';
//  String body = '{"id": "$markerId", "status": "0"}';
//  var headers = {
//    "Accpet": "application/json",
//    "Content-Type": "application/json"
//  };
//  var response = await http.put(Uri.encodeFull(url),headers: headers,body: body);
//  return response.statusCode;
}
