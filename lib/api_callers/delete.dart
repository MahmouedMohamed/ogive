import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final String URL = 'http://192.168.1.100:8000/api/';
Future<int> deleteMarker(oauthToken,markerId) async {
  String url = URL + 'marker'+'?id=$markerId';
  var headers = {
    "Accpet": "application/json",
    "Content-Type": "application/json","Authorization": "Bearer "+oauthToken
  };
  var response = await http.delete(Uri.encodeFull(url),headers: headers);
  return response.statusCode;
}
Future<int> deleteMemory(oauthToken,memoryId) async {
  print('thing $memoryId');
  String url = URL + 'memory'+'?id=$memoryId';
  var headers = {
    "Accpet": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer "+oauthToken
  };
  var response = await http.delete(Uri.encodeFull(url),headers: headers);
  print('thing ${response.body}');
  return response.statusCode;
}