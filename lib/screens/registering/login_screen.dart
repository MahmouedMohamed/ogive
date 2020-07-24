import 'package:flutter/material.dart';
import 'package:ogive/api_callers/get.dart';
import 'package:toast/toast.dart';

import '../../session_manager.dart';

class LoginScreen extends StatelessWidget {
  static final TextEditingController emailController = new TextEditingController();
  static final TextEditingController passwordController = new TextEditingController();

  String get email => emailController.text;
  String get password => passwordController.text;
  Future<dynamic> onSubmit(context) async {
    Map<String, dynamic> map = await getUser(email, password);
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
                gradient: LinearGradient(
              colors: [Colors.white, Colors.lightBlueAccent, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/ogive_version_2.png'),
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 0.0, bottom: 40),
                      child: Text(
                        'OGIVE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white30,
                          shadows: [
                            Shadow(color: Colors.black, offset: Offset(0, 2))
                          ],
                          fontSize: 30,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.transparent),
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
                              labelText: 'User Name:',
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
                              labelText: 'Password :',
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
