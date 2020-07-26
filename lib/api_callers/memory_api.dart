import 'dart:convert';
import 'package:dio/dio.dart';
import 'api_caller.dart';
import 'package:http/http.dart' as http;

class MemoryApi implements ApiCaller {
  @override
  dynamic create({oAuthToken, userData, markerData, memoryData}) async {
    String fileName = memoryData['image'].path.split('/').last;
    FormData formData = new FormData.fromMap(({
      'user_id': memoryData['userId'].toString(),
      'person_name': memoryData['personName'].toString(),
      'birth': memoryData['birthDate'],
      'death': memoryData['deathDate'],
      'life_story': memoryData['lifeStory'].toString(),
      "image": await MultipartFile.fromFile(memoryData['image'].path,
          filename: fileName),
    }));
    var response = await Dio().post(url + 'memory',
        data: formData,
        options: Options(headers: {"Authorization": "Bearer " + oAuthToken}));
    var convertDataToJson = jsonDecode(response.toString());
    if (convertDataToJson['status'] != 'undone') {
      return 'done';
    } else {
      return 'undone';
    }
  }

  @override
  delete({oAuthToken, userData, markerData, memoryData}) async {
    var headers = {
      "Accpet": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer " + oAuthToken
    };
    var response = await http.delete(
        Uri.encodeFull(url + 'memory' + '?id=${memoryData['memoryId']}'),
        headers: headers);
    return response.statusCode;
  }

  @override
  dynamic get(
      {oAuthToken, userData, markerData, memoryData, jobData, newsData}) async {
    var response = await http.get(Uri.encodeFull(url + 'memories'), headers: {
      "Accpet": "application/json",
      "Authorization": "Bearer " + oAuthToken
    });
    var convertDataToJson = jsonDecode(response.body);
    return factory.getMemoriesFromJson(convertDataToJson);
  }

  @override
  dynamic update({oAuthToken, userData, markerData, memoryData}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
