import 'package:shared_preferences/shared_preferences.dart';
import 'models/user.dart';

class SessionManager {
  SharedPreferences sharedPreferences;
  User user;
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
      DateTime.parse(userData[3]),
    );
  }

  createSession(User user) {
    this.user = user;
    sharedPreferences.setStringList('user', user.toList());
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
}
