import 'dart:convert';
import 'package:http/http.dart' as http;
final String URL = 'http://192.168.1.104:8000/api/';
Future<Map<String,dynamic>> register(fullName,userName,email,password) async {
  var body = {'name': fullName, 'user_name': userName,'email': email, 'password': password};
  var response = await http
      .post(Uri.encodeFull(URL+'register'), headers: {"Accpet": "application/json"},body: body);
  if(response.statusCode != 200){
    return null;
  }
  else{
    var convertDataToJson = jsonDecode(response.body);
    String nameError,userNameError,emailError,passwordError;
    if(convertDataToJson['status']=='undone'){
      for(int i=0;i<convertDataToJson['details'].length;i++){
        if(convertDataToJson['details'][i].toString().contains('The name'))
          nameError=convertDataToJson['details'][i];
        else if(convertDataToJson['details'][i].toString().contains('user name'))
          userNameError=convertDataToJson['details'][i];
        else if(convertDataToJson['details'][i].toString().contains('email'))
          emailError=convertDataToJson['details'][i];
        else if(convertDataToJson['details'][i].toString().contains('password'))
          passwordError=convertDataToJson['details'][i];
      }
      List<String> error = [nameError,userNameError,emailError,passwordError];
      return {
        "status": convertDataToJson['status'],
        "details" : error
      };
    }else{
      return {
        "status": convertDataToJson['status'],
      };
    }
  }
}
Future<Map<String,dynamic>> createMarker(latitude,longitude,userId,name,description,quantity,priority) async {
  var body = {
    'Latitude': latitude.toString(),
    'Longitude': longitude.toString(),
    'user_id': userId,
    'name': name,
    'description' : description,
    'quantity' : quantity.toString(),
    'priority' : priority.toString(),
  };
  var response = await http
      .post(Uri.encodeFull(URL+'Marker'), headers: {"Accpet": "application/json"},body: body);
  print('thing ${response.body}');
  var convertDataToJson = jsonDecode(response.body);
  if(response.statusCode != 200){
    print(convertDataToJson);
    return {
      "status": convertDataToJson['status'],
      "details" : convertDataToJson['details'],
    };
  }
  else{
    print(convertDataToJson);
      return {
        "status": convertDataToJson['status'],
      };
    }
}