import 'dart:convert';
import 'api_caller.dart';
import 'package:http/http.dart' as http;

class WeatherApi implements ApiCaller {
  @override
  dynamic create({oAuthToken, userData, markerData, memoryData}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  delete({oAuthToken, userData, markerData, memoryData}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  dynamic get(
      {oAuthToken, userData, markerData, memoryData, jobData, newsData}) async {
    print('thing ${userData}');
    final String weatherURL =
        'http://api.openweathermap.org/data/2.5/weather?lat=' +
            userData['userLocation'].latitude.toString() +
            "&lon=" +
            userData['userLocation'].longitude.toString() +
            "&appid=" +
            'eeb0971ab03a92f6318c8907c2c13e20';
    var headers = {
      "Accpet": "application/json",
      "Content-Type": "application/json"
    };
    var response = await http.get(Uri.encodeFull(weatherURL), headers: headers);
    var convertDataToJson = jsonDecode(response.body);
    return factory.getWeatherFromJson(
        convertDataToJson, userData['userLocation']);
  }

  @override
  dynamic update({oAuthToken, userData, markerData, memoryData}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
