import 'package:flutter/material.dart';
import 'package:ogive/api_callers/api_caller.dart';
import 'package:ogive/api_callers/user_api.dart';
import 'package:toast/toast.dart';
import '../../session_manager.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final TextEditingController emailController =
      new TextEditingController();
  static final TextEditingController passwordController =
      new TextEditingController();
  ApiCaller apiCaller = new UserApi();

  String get email => emailController.text;
  String get password => passwordController.text;

  Future<dynamic> onSubmit(context) async {
    Map<String, dynamic> map =
        await apiCaller.get(userData: {'email': email, 'password': password});
    if (map == null) {
      Toast.show('Email Or Password are inCorrect!', context);
    } else {
      SessionManager sessionManager = new SessionManager();
      print('thing ${sessionManager.sharedPreferences}');
      sessionManager.createSession(
          map.values.toList().elementAt(1), map.values.toList().elementAt(0));
      Navigator.popAndPushNamed(context, 'Home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Material(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sky.jpg'),
                    fit: BoxFit.cover)),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 10,
                        bottom: MediaQuery.of(context).size.height / 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.height / 6,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/ogive_version_2.png'),
                        ),
                      ),
                    )),
//                AnimatedDefaultTextStyle(
//                  child: Text(
//                    'OGIVE',
//                  ),
//                  style: GoogleFonts.sairaCondensed(
//                    color: _color,
//                    fontSize: 80,
//                    fontWeight: FontWeight.w400,
//                    letterSpacing: 2.0,
//                  ),
//                  duration: Duration(seconds: 1),
//                  curve: ElasticInCurve(4),
//                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 1000,
                      right: 10,
                      left: 10),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Column(
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                          child: TextField(
                            controller: emailController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              icon: Icon(
                                Icons.person,
                                color: Colors.pinkAccent,
                              ),
                              labelText: 'Email',
                            ),
                          )),
                      Padding(
                          padding:
                              EdgeInsets.only(top: 20, right: 20, left: 20),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              icon: Icon(
                                Icons.lock,
                                color: Colors.pinkAccent,
                              ),
                              labelText: 'Password',
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonTheme(
                              minWidth: 130,
                              child: RaisedButton(
                                child: Text('Login'),
                                color: Colors.greenAccent,
                                splashColor: Colors.blue,
                                colorBrightness: Brightness.light,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  onSubmit(context);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                  fontSize: 13,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(0, 1))
                                  ],
                                ),
                              ),
                            )
                          ]),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Don\'t have Account? ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "Signup");
                                },
                                child: Text(
                                  'Join Us Now!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
