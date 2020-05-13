import 'package:flutter/material.dart';
import 'package:ogive/api_callers/post.dart';
import 'package:ogive/models/user_location.dart';
import 'package:toast/toast.dart';

import '../session_manager.dart';

class FeedMeIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(onPressed: () async {
            Navigator.pushNamed(context, 'MarkerCreation');
          },
            child: Text('add Marker'),
          ),
          RaisedButton(onPressed: (){
            Navigator.pushNamed(context, 'FeedMe');
          },
            child: Text('Volunteer'),
          ),
        ],
      ),
    );
  }
}
