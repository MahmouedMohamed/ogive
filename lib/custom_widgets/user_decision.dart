import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import '../session_manager.dart';

class UserDecision extends StatefulWidget {
  @override
  _UserDecisionState createState() => _UserDecisionState();
}

class _UserDecisionState extends State<UserDecision> {
  SessionManager sessionManager = SessionManager();
  List<String> info = new List<String>();
  @override
  void initState() {
    super.initState();
    loadSessionManager();
    info = sessionManager.loadWeatherInfo();
    setState(() {});
  }
  loadSessionManager()async{
    await sessionManager.getSessionManager();
    info = await sessionManager.loadWeatherInfo();
    setState(() {});
  }
  _save(outlook,temperature,humidity,windSpeed,decision) async {
    Map<String,dynamic> map = {'outlook' : outlook,'temperature' : temperature,'humidity' : humidity,'windSpeed' : windSpeed,'decision': decision};
    for(int i=0;i<map.values.length;i++) {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${map.keys.elementAt(i)}.txt');
      await file.writeAsString(map.values.elementAt(i).toString()+" ",mode: FileMode.append);
      print('thing done writing ${map.values.elementAt(i)} to ${file.path}');
    }
    sessionManager.clearWeatherInfo();
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
  @override
  Widget build(BuildContext context) {
//    sessionManager.weatherInfoExist()? info = sessionManager.loadWeatherInfo():
//    null;
//    Navigator.popAndPushNamed(context, 'Home');
  print('thing ${info[0]}');
  setState(() {});
  info = sessionManager.loadWeatherInfo();
  setState(() {});
    return info == null
        ? Container(
      color: Colors.lightBlue,
      child: CupertinoActivityIndicator(
        radius: 40,
      ),
    )
        : Container(
      color: Colors.blue,
      child: Column(
        children: [
          Text('${info[0].contains('Black')? 'No' : 'Yes '}'),
          Text('${info[1]}'),
          Text('${info[2]}'),
          Text('${info[3]}'),
          Text('${info[4]}'),
          RaisedButton(onPressed: ()async{await _save(info[1],info[2],info[3],info[4],'yes');},child: Text('Wear White'),),
          RaisedButton(onPressed: ()async{await _save(info[1],info[2],info[3],info[4],'no');},child: Text('Wear Black'),),
        ],
      ),
    );
  }
}
