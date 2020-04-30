import 'package:flutter/material.dart';
import 'package:ogive/api_callers/get.dart';
import 'package:ogive/models/user.dart';
import 'package:toast/toast.dart';

import '../session_manager.dart';
import '../auth.dart';
class LoginScreen extends StatelessWidget {
  static final TextEditingController _email = new TextEditingController();
  static final TextEditingController _password = new TextEditingController();
  String get email => _email.text;
  String get password => _password.text;
  BuildContext context;
  Auth auth = new Auth();
  Future<dynamic> onSubmit() async {
    var user =await auth.signIn(email, password);
    print('thing user = $user');
    if(user == null){
      Toast.show('Email Or Password are inCorrect!',context);
    }
    else if(user.runtimeType == String){
      Toast.show('$user !',context);
    }
    else{
      SessionManager sessionManager = new SessionManager();
      print('thing ${sessionManager.sharedPreferences}');
      sessionManager.createSession(user);
      Navigator.popAndPushNamed(context, 'Home');
    }
  }
  @override
  Widget build(BuildContext context) {
    this.context = context;
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
                          image: AssetImage('assets/images/ogive_version_2.png'),
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 0.0, bottom: 40),
                      child: Text(
                        'Fe Sektak',
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
                            controller: _email,
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
                            controller: _password,
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
                                onPressed: onSubmit,
//                                onPressed: onSubmit() {
//                                  Navigator.pop(context);
//                                  Navigator.pushNamed(context, 'home');
//                                },
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
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
