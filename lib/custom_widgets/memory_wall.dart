import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:toast/toast.dart';
import 'package:google_fonts/google_fonts.dart';

Widget MemoryWallWidget(BuildContext context, double opacity) {
  return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/memory.png'),
          fit: BoxFit.fill),
        ),
        child: GestureDetector(
            onTap: () {
          Navigator.pushNamed(context, 'MemoryWall');
//              Toast.show('Coming Soon', context,duration: 3,backgroundColor: Colors.blue,gravity: 3);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: 10, bottom: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/ogive_version_2.png',
                      height: MediaQuery.of(context).size.height/6,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(text: 'Memory wall',
                        style: GoogleFonts.odibeeSans(
                            fontSize: 70,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                            color: Colors.white,
                            shadows: [Shadow(color: Colors.black,offset: Offset.fromDirection(1,3))]
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom:30,left:10,right: 10),
                  child: Text(
                    'They didn\'t leave us, they are here with their stories. \nThe memory remains.',
                    style: GoogleFonts.catamaran(
                      color: Colors.white,
                      fontSize: 25
                    ),
                    textAlign: TextAlign.center,
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: AnimatedOpacity(
                      opacity: opacity == 1 ? 0 : 1,
                      duration: Duration(seconds: 2),
                      child: Text('Click to Proceed',style: GoogleFonts.quando(color: Colors.white),)),
                )
              ],
            )),
      );
}
