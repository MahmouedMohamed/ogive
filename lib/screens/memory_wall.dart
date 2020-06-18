import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ogive/api_callers/delete.dart';
import 'package:ogive/api_callers/get.dart';
import 'package:ogive/api_callers/post.dart';
import 'package:ogive/models/memory.dart';
import 'package:ogive/session_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class MemoryWall extends StatefulWidget {
  @override
  _MemoryWallState createState() => _MemoryWallState();
}

class _MemoryWallState extends State<MemoryWall> {
  SessionManager sessionManager = new SessionManager();
  List<Memory> memories;
  @override
  void initState() {
    super.initState();
    getAllMemories();
  }

  getAllMemories() async {
    memories = await getMemories(sessionManager.oauthToken);
  }

  Stream<List<Memory>> refresher(Duration interval) async* {
    while (true) {
      await Future.delayed(interval);
      memories = await getMemories(sessionManager.oauthToken);
      yield memories;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "MemoryCreation");
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: refresher(Duration(seconds: 2)),
          initialData: memories,
          builder: (BuildContext context, snapshot) {
            return showBody(context);
          },
        ));
  }

  Widget showBody(context) {
    return memories == null
        ? Container(
            child: Text('Fetching Data'),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.blueGrey))
        : Container(
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Text('Memory Wall'),
                  backgroundColor: Colors.black26,
                  elevation: 3.0,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                      List.generate(memories.length, (index) {
                    return Card(
                      color: Colors.black,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                    color: Colors.white,
                                    onSelected: (value) {
//                                  print('thing $value');
                                      List<String> chosen =
                                          value.toString().split(" ");
                                      if (chosen.elementAt(0) == 'update') {
                                        print(
                                            'thing update ${chosen.elementAt(1)}');
                                      } else {
                                        deleteMemory(sessionManager.oauthToken,chosen.elementAt(1));
                                        setState(() {});
                                        print(
                                            'thing delete ${chosen.elementAt(1)}');
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return (memories[index].userId ==
                                              sessionManager.getUser().ID
                                          ? [
                                              PopupMenuItem(
                                                  value:
//                                                  updateMemory(memories[index].id),
                                                      'update ${memories[index].id}',
                                                  child: Text('Update')),
                                              PopupMenuItem(
                                                  value:
                                                      'delete ${memories[index].id}',
//                                                  'delete ${memories[index].id}',
                                                  child: Text('Delete'))
                                            ]
                                          : [
                                              new PopupMenuItem(
                                                  value:
                                                      'report ${memories[index].id}',
                                                  child: Text('Report'))
                                            ]);
                                    },
                                  ))),
                          Image.network(
                            memories[index].imageLink.replaceAll('\\', ''),
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height / 4,
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                          ExpansionTile(
                            trailing: IconButton(
                                icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            )),
                            title: RichText(
                              text: TextSpan(
                                  text:
                                      ('${memories[index].getPersonName()[0].toUpperCase() + memories[index].getPersonName().substring(1)}' +
                                          '\n'),
                                  style: GoogleFonts.alegreyaSans(
                                      fontSize: 24, color: Colors.amber),
                                  children: [
                                    TextSpan(
                                        text: 'In our hearts',
                                        style: GoogleFonts.alegreyaSans(
                                            fontSize: 18, color: Colors.teal))
                                  ]),
                            ),
                            children: <Widget>[
                              Text(
                                memories[index].birthDate.year.toString() +
                                    ' - ' +
                                    memories[index].deathDate.year.toString() +
                                    ' - ∞',
                                style: TextStyle(color: Colors.amber),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        '${memories[index].getLifeStory()}',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: Colors.amber),
                                      ))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.heart,
                                      color: memories[index]
                                              .inIn(sessionManager.getUser().ID)
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        Toast.show('Refreshing', context);
                                        likeUnlikeMemory(sessionManager.oauthToken,memories[index].id,
                                            sessionManager.getUser().ID);
                                      });
                                    },
                                  ),
                                  Text(
                                    '${memories[index].likes.length}',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                    );
                  })),
                )
              ],
            ));
  }
}
