import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedMeIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            FontAwesomeIcons.info,
            color: Colors.white,
            size: 23,
          ),
          backgroundColor: Colors.blue[400],
          elevation: 10,
          splashColor: Colors.blue,
          tooltip: 'Info',
          heroTag: "info",
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/giving.png'),
              fit: BoxFit.cover,
            )),
            child: ClipRRect(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.grey.withOpacity(0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        color: Colors.transparent.withOpacity(0.1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Text(
                                'Hey, you have',
                                style: GoogleFonts.catamaran(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        '123',
                                        style: GoogleFonts.anton(
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'Markers published',
                                        style: GoogleFonts.catamaran(
                                            fontSize: 12, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Text(
                                    '&',
                                    style: GoogleFonts.catamaran(
                                        fontSize: 40, color: Colors.white),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        '123',
                                        style: GoogleFonts.anton(
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'Markers collected',
                                        style: GoogleFonts.catamaran(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Your progress',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.catamaran(
                                  fontSize: 18, color: Colors.white),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top:6,bottom: 2, left: 5, right: 5),
                              child: LinearProgressIndicator(
                                value: 0.3,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            Text(
                              '62 Markers left to your prize.',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.catamaran(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonTheme(
                            buttonColor: Colors.amber,
                            hoverColor: Colors.blueAccent,
                            splashColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: RaisedButton.icon(
                              elevation: 10,
                              onPressed: () async {
                                Navigator.pushNamed(context, 'MarkerCreation');
                              },
                              icon: Icon(
                                Icons.flag,
                                color: Colors.teal,
                              ),
                              label: Text(
                                'Add marker',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          ButtonTheme(
                            buttonColor: Colors.amber,
                            hoverColor: Colors.blueAccent,
                            splashColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: RaisedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, 'FeedMe');
                              },
                              icon: Icon(
                                Icons.flash_on,
                                color: Colors.redAccent,
                              ),
                              label: Text('Volunteer',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Text('Thank you for making the world a better place 😀',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aBeeZee(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                          )),
                    ],
                  )),
            ))));
  }
}
