import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

final String URL = 'http://192.168.1.100:8000/api/';
Future<Map<String, dynamic>> register(
    fullName, userName, email, password) async {
  var body = {
    'name': fullName,
    'user_name': userName,
    'email': email,
    'password': password
  };
  var response = await http.post(Uri.encodeFull(URL + 'register'),
      headers: {"Accpet": "application/json"}, body: body);
  if (response.statusCode != 200) {
    return null;
  } else {
    var convertDataToJson = jsonDecode(response.body);
    String nameError, userNameError, emailError, passwordError;
    if (convertDataToJson['status'] == 'undone') {
      for (int i = 0; i < convertDataToJson['details'].length; i++) {
        if (convertDataToJson['details'][i].toString().contains('The name'))
          nameError = convertDataToJson['details'][i];
        else if (convertDataToJson['details'][i]
            .toString()
            .contains('user name'))
          userNameError = convertDataToJson['details'][i];
        else if (convertDataToJson['details'][i].toString().contains('email'))
          emailError = convertDataToJson['details'][i];
        else if (convertDataToJson['details'][i]
            .toString()
            .contains('password'))
          passwordError = convertDataToJson['details'][i];
      }
      List<String> error = [
        nameError,
        userNameError,
        emailError,
        passwordError
      ];
      return {"status": convertDataToJson['status'], "details": error};
    } else {
      return {
        "status": convertDataToJson['status'],
      };
    }
  }
}

Future<Map<String, dynamic>> createMarker(oauthToken,
    latitude, longitude, userId, name, description, quantity, priority) async {
  var body = {
    'Latitude': latitude.toString(),
    'Longitude': longitude.toString(),
    'user_id': userId,
    'name': name,
    'description': description,
    'quantity': quantity.toString(),
    'priority': priority.toString(),
  };
  var response = await http.post(Uri.encodeFull(URL + 'marker'),
      headers: {"Accpet": "application/json","Authorization": "Bearer "+oauthToken}, body: body);
  print('thing ${response.body}');
  var convertDataToJson = jsonDecode(response.body);
  if (response.statusCode != 200) {
    print(convertDataToJson);
    return {
      "status": convertDataToJson['status'],
      "details": convertDataToJson['details'],
    };
  } else {
    print(convertDataToJson);
    return {
      "status": convertDataToJson['status'],
    };
  }
}

Future<String> createMemory(oauthToken,
    userId, personName, birthDate, deathDate, lifeStory, image) async {
  String fileName = image.path.split('/').last;
  FormData formData = new FormData.fromMap(({
    'user_id': userId.toString(),
    'person_name': personName.toString(),
    'birth': birthDate,
    'death': deathDate,
    'life_story': lifeStory.toString(),
    "image": await MultipartFile.fromFile(image.path, filename: fileName),
  }));
  var response = await Dio().post(URL + 'memory', data: formData,options: Options(
    headers: {"Authorization": "Bearer "+oauthToken}
  ));
  print('thing ${response}');
  var convertDataToJson = jsonDecode(response.toString());
  if (convertDataToJson['status'] != 'undone') {
    return 'done';
  } else {
    return 'undone';
  }
}
Future<String> likeUnlikeMemory(oauthToken,
    memoryId, userId) async {
  var body = {
    'user_id': userId,
    'memory_id': memoryId,
  };
  var response = await http.post(Uri.encodeFull(URL + 'like'),
      headers: {"Accpet": "application/json","Authorization": "Bearer "+oauthToken}, body: body);
  print('thing ${response.body}');
  var convertDataToJson = jsonDecode(response.body);
  print('thing ${response}');
  if (convertDataToJson['status'] != 'undone') {
    return 'done';
  } else {
    return 'undone';
  }
}