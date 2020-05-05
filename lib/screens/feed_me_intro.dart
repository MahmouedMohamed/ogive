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
            UserLocation userLocation= new UserLocation();
            SessionManager sessionManager =  new SessionManager();
            if(userLocation.getLatLng()==null)
              await userLocation.getUserLocation();
            Map<String,dynamic> map = await createMarker(userLocation.getLatLng().latitude,userLocation.getLatLng().longitude,sessionManager.getUser().getID(),1);
            Toast.show(
              '${map.values.elementAt(0)}',
              context
            );
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
