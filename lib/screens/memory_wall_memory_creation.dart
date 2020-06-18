import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';
import 'package:ogive/api_callers/post.dart';
import 'package:toast/toast.dart';

import '../session_manager.dart';

class MemoryCreation extends StatefulWidget {
  @override
  _MemoryCreationState createState() => _MemoryCreationState();
}

class _MemoryCreationState extends State<MemoryCreation> {
  SessionManager sessionManager = new SessionManager();
  TextEditingController personName = new TextEditingController();
  TextEditingController lifeStory = new TextEditingController();
  DateTime birthDate = DateTime.now();
  DateTime deathDate = DateTime.now();
  File image;
  String _path;
  Future<File> pickImageFromGallery(ImageSource source) {
    return ImagePicker.pickImage(source: source);
  }

  _getPath(ImageSource source) async {
    image =
        await pickImageFromGallery(source); // the method return Future<File>
    setState(() {
      _path = image.path;
    });
  }

  _onPressed() async {
    if (await createMemory(sessionManager.oauthToken,sessionManager.getUser().id, personName.text,
            birthDate, deathDate, lifeStory.text, image) ==
        'done') {
      Toast.show('Memory will always remain!', context);
      Navigator.popAndPushNamed(context, "MemoryWall");
    } else {
      Toast.show('Please fill all required fields', context);
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
                padding:
                    EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/black_white.jpg'),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/20,bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Create Memory',style: GoogleFonts.arimo(
                          fontSize: 40, color: Colors.amber[700],letterSpacing: 1.5,fontWeight: FontWeight.w800),),
                      SizedBox(height:20),
                      TextField(
                        controller: personName,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          labelText: 'Name',
                          labelStyle: GoogleFonts.arimo(
                              fontSize: 20, color: Colors.amber),
                          hintText: 'What is his/her Name?',
                          hintStyle: GoogleFonts.arimo(
                              fontSize: 16, color: Colors.amber[200]),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: lifeStory,
                        maxLines: 5,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: 'Story',
                          labelStyle: GoogleFonts.arimo(
                              fontSize: 20, color: Colors.amber),
                          hintText: 'Tell us the story of his/her life',
                          hintStyle: GoogleFonts.arimo(
                              fontSize: 16, color: Colors.amber[400]),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Current birth date: ${birthDate.year}/${birthDate.month}/${birthDate.day}',
                      style: GoogleFonts.arimo(
                          fontSize: 18, color: Colors.amber),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          DateTime date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            setState(() {
                              birthDate = date;
                            });
                          }
                        },
                        child: Text('Change Birth Date',style: GoogleFonts.arimo(
                            fontSize: 14, color: Colors.blue[600])),
                        color: Colors.amber[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Current leaving date: ${deathDate.year}/${deathDate.month}/${deathDate.day}',
                      style: GoogleFonts.arimo(
                          fontSize: 18, color: Colors.amber),),
                      RaisedButton(
                        onPressed: () async {
                          DateTime date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            setState(() {
                              deathDate = date;
                            });
                          }
                        },
                        child: Text('Change Leaving Date',style: GoogleFonts.arimo(
                            fontSize: 14, color: Colors.blue[600])),
                        color: Colors.amber[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _path != null
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Image.file(image, fit: BoxFit.cover))
                          : SizedBox(),
                      RaisedButton(
                          onPressed: () async {
                            await _getPath(ImageSource.gallery);
                          },
                          child: Text('Change Picture',style: GoogleFonts.arimo(
                              fontSize: 14, color: Colors.blue[600])),
                        color: Colors.amber[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: RaisedButton(
                              onPressed: _onPressed,
                              child: Text('Submit Memory',style: GoogleFonts.arimo(
                                  fontSize: 16, color: Colors.blue[600],fontWeight: FontWeight.w700)),
                            color: Colors.amber[200],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          ),),
                    ],
                  ),
                ))));
  }
}
