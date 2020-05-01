import 'package:shared_preferences/shared_preferences.dart';
import 'models/user.dart';

class SessionManager {
  SharedPreferences sharedPreferences;
  User user;
  String oauthToken;
  SessionManager._privateConstructor();

  static final SessionManager _instance = SessionManager._privateConstructor();

  factory SessionManager() {
    return _instance;
  }
  getSessionManager() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  loadSession() {
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
    sharedPreferences.setString('oauthToken', oauthToken);
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
