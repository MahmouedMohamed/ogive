import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/flutter_dialogflow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ogive/models/message.dart';
import 'package:ogive/session_manager.dart';

class Bot extends StatefulWidget {
  @override
  _BotState createState() => _BotState();
}

class _BotState extends State<Bot> with SingleTickerProviderStateMixin {
  List<Message> messages = new List<Message>();
  TextEditingController message = new TextEditingController();
  SessionManager sessionManager = new SessionManager();
  sendMessage(message) async {
    //ToDo change your token to client token
    Dialogflow dialogFlow =
        Dialogflow(token: "58c27b19f95d41b0886c176cb610c38d");
    if (message.toString().contains(' ')) {
      message = message.toString().replaceAll(' ', '_');
    }
    AIResponse response = await dialogFlow.sendQuery(message.toString());
    setState(() {
      messages.add(new Message(response.getMessageResponse(), 'Helpo',
          DateTime.parse(response.getTimestamp)));
    });
    print('thing ${response.getMessageResponse()}');
  }

  @override
  void initState() {
    super.initState();
    sendMessage('hi');
  }

  @override
  void dispose() {
   super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.blueAccent,
            elevation: 3,
            title: Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.robot,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Helpo')
              ],
            ),
            leading: BackButton(),
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 40),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.green[100]),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height - 110,
                child: SingleChildScrollView(
                  child: showMessages(),
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                ),
              ),
              Divider(
                height: 1,
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Enter your message'),
                                controller: message,
                              ),
                              width: MediaQuery.of(context).size.width - 50,
                            ),
                            SizedBox(
                              child: IconButton(
                                icon: Icon(Icons.send),
                                onPressed: () {
                                  sendMessage(message.text);
                                  setState(() {
                                    messages.add(new Message(
                                        message.text,
                                        sessionManager.getUser().name,
                                        DateTime.now()));
                                  });
                                  message.clear();
                                },
                                iconSize: 30,
                              ),
                              width: 40,
                            ),
                          ],
                        ),
                      )),
            ],
          ),
        ),
      ),
    );
  }

  Widget showMessages() {
    return Column(children: <Widget>[
      for (var item in messages)
        item.sender == 'Helpo'
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                      bottom: 10,
                      right: MediaQuery.of(context).size.width / 2 - 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.robot,
                          size: 13,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              child: Text(
                                item.body,
                                style: GoogleFonts.arimo(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            : Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: EdgeInsets.only(
                      right: 5,
                      bottom: 10,
                      left: MediaQuery.of(context).size.width / 2 - 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Flexible(
                            child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Text(
                              item.body,
                              style: GoogleFonts.arimo(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ),
                        )),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.person,
                          size: 17,
                          color: Colors.black,
                        ),
                      ],
                    )),
              ),
    ]);
  }
}
