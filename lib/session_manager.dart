import 'package:shared_preferences/shared_preferences.dart';
import 'models/user.dart';

class SessionManager {
  SharedPreferences sharedPreferences;
  User user;
  String oauthToken;
  DateTime sessionExpire;
  SessionManager._privateConstructor();

  static final SessionManager _instance = SessionManager._privateConstructor();

  factory SessionManager() {
    return _instance;
  }
  getSessionManager() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  loadSession() {
    sessionExpire = DateTime.parse(sharedPreferences.getString('sessionExpire'));
    if(sessionExpire.isBefore(DateTime.now())){
      logout();
    }
    List<String> userData = sharedPreferences.getStringList('user');
    user = new User(
      userData[0],
      userData[1],
      userData[2],
      userData[3],
      userData[4] == 'null' ? null : DateTime.parse(userData[4]),
      DateTime.parse(userData[5]),
      DateTime.parse(userData[6]),
    );
    oauthToken = sharedPreferences.getString('oauthToken');
  }

  createSession(User user, String oauthToken) {
    this.user = user;
    this.oauthToken = oauthToken;
    sharedPreferences.setStringList('user', user.toList());
    sharedPreferences.setString('sessionExpire', DateTime.now().add(Duration(days: 30)).toString());
    sharedPreferences.setString('oauthToken', oauthToken);
  }
  bool weatherInfoExist(){
    return sharedPreferences.containsKey('decision');
  }
  createWeatherInfo(Map<String, dynamic> data){
    sharedPreferences.setString('decision', data.values.elementAt(0));
    sharedPreferences.setString('condition', data.values.elementAt(1).condition.toString());
    sharedPreferences.setString('temperature', data.values.elementAt(1).temperature.toString());
    sharedPreferences.setString('humidity', data.values.elementAt(1).humidity.toString());
    sharedPreferences.setString('windSpeed', data.values.elementAt(1).windSpeed.toString());
    print('thing HERE');
  }
  loadWeatherInfo(){
    print('thing hh ${sharedPreferences.getString('decision')}');
    return[
      sharedPreferences.getString('decision'),
      sharedPreferences.getString('condition'),
      sharedPreferences.getString('temperature'),
      sharedPreferences.getString('humidity'),
      sharedPreferences.getString('windSpeed'),
    ];
  }
  clearWeatherInfo(){
    sharedPreferences.remove('decision');
    sharedPreferences.remove('condition');
    sharedPreferences.remove('temperature');
    sharedPreferences.remove('humidity');
    sharedPreferences.remove('windSpeed');
  }
  bool isLoggin() {
    return (sharedPreferences.containsKey("user"));
  }

  User getUser() {
    return user;
  }

  logout() {
    sharedPreferences.clear();
  }

  String getOauthToken() {
    return oauthToken;
  }
}
