import 'dart:async';
import 'package:http/http.dart' as http;

final String URL = 'http://192.168.1.101:8000/api/';
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
