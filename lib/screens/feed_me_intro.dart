import 'package:flutter/material.dart';

class FeedMeIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(onPressed: (){},
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
