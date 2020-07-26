import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_caller.dart';

class UserApi implements ApiCaller {
  @override
  dynamic create({oAuthToken, userData, markerData, memoryData}) async {
    var body = {
      'name': userData['fullName'],
      'user_name': userData['userName'],
      'email': userData['email'],
      'password': userData['password']
    };
    var response = await http.post(Uri.encodeFull(url + 'register'),
        headers: {"Accpet": "application/json"}, body: body);
    if (response.statusCode != 200) {
      return null;
    } else {
      var convertDataToJson = jsonDecode(response.body);
      String nameError, userNameError, emailError, passwordError;
      if (convertDataToJson['status'] == 'undone') {
        List<dynamic> errorDetails = convertDataToJson['details'];
        errorDetails.forEach((errorDetail) {
          if (errorDetail.toString().contains('The name'))
            nameError = errorDetail;
          else if (errorDetail.toString().contains('user name'))
            userNameError = errorDetail;
          else if (errorDetail.toString().contains('email'))
            emailError = errorDetail;
          else if (errorDetail.toString().contains('password'))
            passwordError = errorDetail;
        });
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

  @override
  delete({oAuthToken,userData,markerData,memoryData}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  dynamic update({oAuthToken,userData,markerData,memoryData})  {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  dynamic get({oAuthToken,userData,markerData,memoryData,jobData,newsData}) async {
    var body = {'email': userData['email'], 'password': userData['password']};
    var response = await http.post(Uri.encodeFull(url + 'login'),
        headers: {"Accpet": "application/json"}, body: body);
    if (response.statusCode != 200) {
      return null;
    } else {
      var convertDataToJson = jsonDecode(response.body);
      print('thing $convertDataToJson');
      return convertDataToJson['error'] == null
          ? {
              "oauthToken": convertDataToJson['token'],
              "user": factory.getUserFromJson(convertDataToJson)
            }
          : null;
    }
  }
}
