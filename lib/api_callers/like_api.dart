import 'dart:convert';
import 'api_caller.dart';
import 'package:http/http.dart' as http;

class LikeApi implements ApiCaller {
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
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  dynamic update({oAuthToken, userData, markerData, memoryData}) async {
    var body = {
      'user_id': userData['userId'],
      'memory_id': memoryData['memoryId'],
    };
    var response = await http.post(Uri.encodeFull(url + 'like'),
        headers: {
          "Accpet": "application/json",
          "Authorization": "Bearer " + oAuthToken
        },
        body: body);
    var convertDataToJson = jsonDecode(response.body);
    if (convertDataToJson['status'] != 'undone') {
      return 'done';
    } else {
      return 'undone';
    }
  }
}
