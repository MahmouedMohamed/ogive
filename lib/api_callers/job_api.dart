import 'dart:convert';
import 'api_caller.dart';
import 'package:http/http.dart' as http;

class JobApi implements ApiCaller {
  @override
  create({oAuthToken, userData, markerData, memoryData}) {
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
        Uri.encodeFull('https://remotive.io/api/remote-jobs?limit=100'),
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
