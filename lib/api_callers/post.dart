import 'dart:convert';
import 'package:http/http.dart' as http;
final String URL = 'http://192.168.1.103:8000/api/';
Future<Map<String,dynamic>> register(fullName,userName,email,password) async {
  var body = {'name': fullName, 'user_name': userName,'email': email, 'password': password};
  var response = await http
      .post(Uri.encodeFull(URL+'register'), headers: {"Accpet": "application/json"},body: body);
  if(response.statusCode != 200){
    return null;
  }
  else{
    var convertDataToJson = jsonDecode(response.body);
//    print('thing $convertDataToJson');
    String nameError,userNameError,emailError,passwordError;
//    print('thing ${convertDataToJson['details'].length}');
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
//      print('thing $nameError \n $userNameError \n $emailError \n $passwordError');
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
//    User user = new User(
//      convertDataToJson['user']['id'].toString(),
//      convertDataToJson['user']['name'],
//      convertDataToJson['user']['user_name'],
//      convertDataToJson['user']['email'],
//      convertDataToJson['user']['email_verified_at'] == null ? null : DateTime.parse(convertDataToJson['user']['email_verified_at']),
//      DateTime.parse(convertDataToJson['user']['created_at']),
//      DateTime.parse(convertDataToJson['user']['updated_at']),
//    );
//    Map<String,dynamic> map = {"oauthToken": convertDataToJson['token'],"user" : user};
//    print('thing  $map');
//    return map;
  }
}