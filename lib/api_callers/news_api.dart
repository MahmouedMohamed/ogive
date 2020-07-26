import 'dart:convert';
import 'api_caller.dart';
import 'package:http/http.dart' as http;

class NewsApi implements ApiCaller {
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
    var response = await http.get(
        Uri.encodeFull(
            'http://content.guardianapis.com/world/${newsData['query']}?api-key=7bd910b5-889e-4446-904d-dae19d3890bc&page=${newsData['pageNumber']}'),
        headers: {"Accpet": "application/json"});
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  @override
  dynamic update({oAuthToken, userData, markerData, memoryData}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
