import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ogive/custom_widgets/text_field.dart';
import '../auth.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _fullName = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  String nameError;
  String emailError;
  String passwordError;
  bool agree = false;
  bool errorAgree = false;
  Auth auth = new Auth();
  PlatformException platformException;
  @override
  void initState() {
    super.initState();
  }

  void _register() async {
    agree == false ? errorAgree = true : errorAgree = false;
    if (agree == true) {
      var done = await auth.signUp(
          _fullName.value.text, _email.value.text, _password.value.text);
      if (done.runtimeType == PlatformException) {
        platformException = PlatformException(
            code: done.code, details: done.details, message: done.message);
        platformException.message.contains('Password')
            ? passwordError = platformException.message
            : passwordError = null;
        platformException.message.contains('email')
            ? emailError = platformException.message
            : emailError = null;
      } else {
        Navigator.popAndPushNamed(context, "Login");
      }
    }
    setState(() {});
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
                  gradient: RadialGradient(radius: 1, colors: [
                Color.fromRGBO(242, 95, 76, 0.5),
                Color.fromRGBO(229, 49, 112, 0.5),
                Color.fromRGBO(15, 14, 23, 1)
              ])),
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 30, bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/ogive_version_2.png',
                      alignment: Alignment.topCenter,
                      height: MediaQuery.of(context).size.height / 7,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textField(
                        _fullName,
                        'Full name',
                        Icons.person,
                        Colors.green,
                        false,
                        null,
                        'Enter your real name',
                        nameError),
                    textField(
                        _email,
                        'Email',
                        Icons.email,
                        Color.fromRGBO(255, 216, 3, 1),
                        false,
                        null,
                        'Enter your email',
                        emailError), //must be unique
                    textField(
                        _password,
                        'Password',
                        Icons.lock,
                        Color.fromRGBO(242, 95, 76, 1),
                        true,
                        null,
                        'use powerful password',
                        passwordError), //good password
                    CheckboxListTile(
                      value: agree,
                      onChanged: (value) {
                        setState(() {
                          agree = value;
                        });
                      },
                      title: Text('I agree terms'),
                      controlAffinity: ListTileControlAffinity.leading,
                      subtitle: GestureDetector(
                        onTap: () {
                          //Todo: add terms to read
                        },
                        child: Text('Click here to see our terms'),
                      ),
                      secondary: Icon(Icons.book),
                    ),
                    Visibility(
                        child: Text('Why u don\'t wanna agree? ._.',
                            style: TextStyle(color: Colors.red)),
                        visible: errorAgree),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      color: Color.fromRGBO(255, 137, 6, 1),
                      onPressed: _register,
                      child: Text('Signup'),
                    ),
                  ],
                ),
              )),
        ));
  }
}
