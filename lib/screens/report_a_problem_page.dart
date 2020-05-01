//import 'package:flutter/material.dart';
//import 'package:mailer/mailer.dart';
//import 'package:mailer/smtp_server.dart';
//
//class ReportProblemPage extends StatefulWidget {
//  @override
//  _ReportProblemPageState createState() => _ReportProblemPageState();
//}
//
//class _ReportProblemPageState extends State<ReportProblemPage> {
//  int _selectedIndex = 2;
//  final pageOption = ["StayInTouch", "Home", "ReportProblem"];
//  static final TextEditingController _email = new TextEditingController();
//  static final TextEditingController _password = new TextEditingController();
//  static final TextEditingController _subject = new TextEditingController();
//  static final TextEditingController _body = new TextEditingController();
//  String get email => _email.text;
//  String get password => _password.text;
//  String get subject => _subject.text;
//  String get body => _body.text;
//  void _onItemTapped(int index) {
//    setState(() {
//      _selectedIndex = index;
//      Navigator.popAndPushNamed(context, pageOption[_selectedIndex]);
//    });
//  }
//
//  Future<void> _onSubmit() async {
//    final smtpServer = gmail(email, password);
////    if(email.contains('yahoo.com')){
////      smtpServer = yahoo(email, password);
////    }
////    else {
//
////    }
//    print('SendingEmail ${smtpServer.host}');
//    final message = Message()
//      ..from = Address(email, '$email')
//      ..recipients.add('mahmouedmartin222@yahoo.com')
//      ..subject = '$subject :: 😀 :: ${DateTime.now()}'
//      ..text = '$body';
//    try {
//      //salmamuhammed122@gmail.com      baliim3ak
//      print('SendingEmail ${smtpServer.host}');
//      final sendReport = await send(message, smtpServer);
//      print('SendingEmail sent: ' + sendReport.toString());
//    } on MailerException catch (e) {
//      print('SendingEmail not sent.');
//      print('SendingEmail $e');
//      for (var p in e.problems) {
//        print('SendingEmail Problem: ${p.code}: ${p.msg}');
//      }
//    }
////      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
//    print('SendingEmail SMTP ${smtpServer.xoauth2Token}');
//  }
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//        onTap: () {
//          FocusScope.of(context).requestFocus(new FocusNode());
//        },
//        child: Scaffold(
//            appBar: AppBar(
//              title: Text('Error Reporting'),
//              centerTitle: true,
//            ),
//            bottomNavigationBar: BottomNavigationBar(
//              items: [
//                BottomNavigationBarItem(
//                    icon: Icon(Icons.people), title: Text('Stay in touch')),
//                BottomNavigationBarItem(
//                    icon: Icon(Icons.home), title: Text('Home')),
//                BottomNavigationBarItem(
//                    icon: Icon(
//                      Icons.email,
//                    ),
//                    title: Text(
//                      'Contact Us',
//                    ))
//              ],
//              currentIndex: _selectedIndex,
//              selectedItemColor: Colors.amber[800],
//              onTap: _onItemTapped,
//            ),
//            body: Container(
////              alignment: Alignment.center,
//                child: Padding(
//              padding: EdgeInsets.only(top: 30, right: 40, left: 40),
//              child: SingleChildScrollView(
//                child: Column(
//                  mainAxisSize: MainAxisSize.max,
//                  children: [
//                    Text(
//                        'We suggest you to use gmail or yahoo email for'
//                            ' contacting us.\n'),
//                    Text(
//                      'Please Note that you email and password are protected '
//                          'and won\'t be saved for security concerns.\n',
//                      style: TextStyle(color: Colors.green),
//                    ),
//                    RichText(
//                      textAlign: TextAlign.center,
//
//                        strutStyle: StrutStyle(),
//                        text: TextSpan(children: [
//                      TextSpan(
//                        text:
//                            'Send us a creative email within the '
//                                'following subjects ',
//                        style: TextStyle(color: Colors.blue),
//                        children: [
//                          TextSpan(
//                              text: 'Bugs,',
//                              style: TextStyle(color: Colors.orange)),
//                          TextSpan(
//                              text: 'Errors,', style: TextStyle(color: Colors.red)),
//                          TextSpan(
//                              text: 'Enhancement,',
//                              style: TextStyle(color: Colors.green)),
//                          TextSpan(
//                              text: 'Suggestions.',
//                              style: TextStyle(color: Colors.purpleAccent))
//                        ]
//                      ),
//                    ])),
//                    TextField(
//                      keyboardAppearance: Brightness.dark,
//                      decoration: InputDecoration(
//                          labelText: 'E-mail', hintText: 'Enter Your Email'),
//                      controller: _email,
//                    ),
//                    TextField(
//                      decoration: InputDecoration(
//                          labelText: 'Password',
//                          hintText: 'Enter Your email Password'),
//                      controller: _password,
////                      obscureText: true,
//                    ),
//                    TextField(
//                      decoration: InputDecoration(
//                          labelText: 'Subject',
//                          hintText: 'What\'s your message about?'),
//                      controller: _subject,
//                    ),
//                    TextField(
//                      maxLines: 5,
//                      decoration: InputDecoration(
//                        labelText: 'Body',
//                        hintMaxLines: 5,
//                      ),
//                      controller: _body,
//                    ),
//                    SizedBox(
//                      height: 50,
//                    ),
//                    RaisedButton.icon(
//                      onPressed: _onSubmit,
//                      label: Text('Submit'),
//                      icon: Icon(
//                        Icons.forward,
//                        color: Colors.green,
//                      ),
//                    )
//                  ],
//                ),
//              ),
//            ))));
//  }
//}
