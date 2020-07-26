import 'dart:convert';
import 'api_caller.dart';
import 'package:http/http.dart' as http;

class MarkerApi implements ApiCaller{

  @override
  dynamic create({oAuthToken,userData,markerData,memoryData}) async {
    var body = {
      'Latitude': markerData['userLocation'].latitude.toString(),
      'Longitude': markerData['userLocation'].longitude.toString(),
      'user_id': markerData['userId'],
      'name': markerData['name'],
      'description': markerData['description'],
      'quantity': markerData['quantity'].toString(),
      'priority': markerData['priority'].toString(),
    };
    var response = await http.post(Uri.encodeFull(url + 'marker'),
        headers: {"Accpet": "application/json","Authorization": "Bearer "+oAuthToken}, body: body);
    var convertDataToJson = jsonDecode(response.body);
    if (response.statusCode != 200) {
      return {
        "status": convertDataToJson['status'],
        "details": convertDataToJson['details'],
      };
    } else {
      return {
        "status": convertDataToJson['status'],
      };
    }
  }

  @override
  delete({oAuthToken,userData,markerData,memoryData}) async {
    var headers = {
      "Accpet": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer "+oAuthToken
    };
    var response = await http.delete(Uri.encodeFull(url+'marker?id=${markerData['markerId']}'),headers: headers);
    return response.statusCode;
  }

  @override
  dynamic get({oAuthToken,userData,markerData,memoryData,jobData,newsData}) async {
      var response = await http.get(Uri.encodeFull(url + 'markers'),
          headers: {"Accpet": "application/json","Authorization": "Bearer "+oAuthToken});
      var convertDataToJson = jsonDecode(response.body);
      return factory.getMarkersFromJson(convertDataToJson);
  }

  @override
  dynamic update({oAuthToken,userData,markerData,memoryData})  {
    // TODO: implement update
    throw UnimplementedError();
  }

}