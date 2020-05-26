import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../session_manager.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  SessionManager sessionManager;
  @override
  void initState() {
    super.initState();
    sessionManager = new SessionManager();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Material(
      child: Container(
        decoration: BoxDecoration(
//          color: Colors.amber[300].withOpacity(0.2),
            image: DecorationImage(
//          image: AssetImage('assets/images/sky.jpg'),
          image: AssetImage('assets/images/black_white.jpg'),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(Colors.amber, BlendMode.color),
        )
//          gradient: LinearGradient(
//              colors: [Colors.amber, Colors.black],
//              radius: 0.5,
//            focalRadius: 0.5
//          )
            ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
//                color: Colors.red[300],
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
//                  image: DecorationImage(
//                    image: AssetImage('assets/images/sky.jpg'),
//                    fit: BoxFit.cover,
//                    colorFilter: new ColorFilter.mode(
//                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
//                  )
              ),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    BackButton(color: Colors.amber),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Profile',
                      style: GoogleFonts.alegreyaSans(
                          fontSize: 27,
                          fontWeight: FontWeight.w400,
                          color: Colors.amber),
                    ),
                  ],
                ),
                Divider(
                  height: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: CircleAvatar(
                          child:
                              Icon(Icons.person, size: 70, color: Colors.amber),
                          minRadius: 40,
                          maxRadius: 60,
                          backgroundColor: Colors.white.withOpacity(0.5),
                        ),
                        onTap: () {
                          onImagePressed(context);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${sessionManager.getUser().name}',
                        style: GoogleFonts.arimo(
                            decoration: TextDecoration.none,
                            color: Colors.amber,
                            fontWeight: FontWeight.w400,
                            fontSize: 30,
                            letterSpacing: 1.5),
                      )
                    ],
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.transparent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ButtonTheme(
                    height: MediaQuery.of(context).size.height / 15,
                    minWidth: MediaQuery.of(context).size.width,
                    child: RaisedButton.icon(
//                      elevation: 3,
                      color: Colors.black.withOpacity(0.1),
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.medal,
                        color: Colors.amber[700],
                      ),
                      label: Text(
                        'Achievement System',
                        style: GoogleFonts.amarante(
                            fontSize: 16, color: Colors.amber),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    height: MediaQuery.of(context).size.height / 15,
                    minWidth: MediaQuery.of(context).size.width,
                    child: RaisedButton.icon(
                      color: Colors.black.withOpacity(0.1),
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.lock,
                        color: Colors.blue,
                      ),
                      label: Text(
                        'Reset Password',
                        style: GoogleFonts.amarante(
                            fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    height: MediaQuery.of(context).size.height / 15,
                    minWidth: MediaQuery.of(context).size.width,
                    child: RaisedButton.icon(
                      color: Colors.black.withOpacity(0.1),
                      onPressed: () {},
                      icon: Icon(
                        Icons.report_problem,
                        color: Colors.red[700],
                      ),
                      label: Text(
                        'Delete Your Account',
                        style: GoogleFonts.amarante(
                            color: Colors.red[600], fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                padding:
                    EdgeInsets.only(top: 40, left: 5, right: 5, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'The world is better place because you are here.',
                      style: GoogleFonts.arimo(color: Colors.amber),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '"Ogive family"',
                      style: GoogleFonts.arimo(color: Colors.amber),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image(
                      image: AssetImage('assets/images/ogive_version_2.png'),
//                      height: 40,
                      width: 40,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onImagePressed(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 2,
                buttonColor: Colors.transparent,
//                shape: Border(bottom: BorderSide(width: 1)),
                child: RaisedButton(
                  elevation: 0.0,
                  onPressed: () {},
                  child: Text('Show profile picture'),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.black.withOpacity(0.5),
                indent: 10,
                endIndent: 10,
              ),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width / 2,
                buttonColor: Colors.transparent,
//                shape: Border(bottom: BorderSide(width: 1)),
                child: RaisedButton(
                  elevation: 0.0,
                  onPressed: () {},
                  child: Text('Change profile picture'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
