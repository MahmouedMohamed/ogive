import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ogive/api_callers/delete.dart';
import 'package:ogive/api_callers/get.dart';
import 'package:ogive/api_callers/put.dart';
import 'package:ogive/models/user_location.dart';
import 'package:toast/toast.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as math;

class FeedMe extends StatefulWidget {
  @override
  _FeedMeState createState() => _FeedMeState();
}

class _FeedMeState extends State<FeedMe> {
  GoogleMap googleMap;
  UserLocation userLocation;
  List<Marker> markers;
  bool following = false;
  Marker chosedMarker;
  bool acquired = false;
  @override
  void initState() {
    super.initState();
    userLocation = new UserLocation();
  }

  double CalculationByDistance(LatLng StartP, LatLng EndP) {
    int Radius = 6371; // radius of earth in Km
    double lat1 = StartP.latitude;
    double lat2 = EndP.latitude;
    double lon1 = StartP.longitude;
    double lon2 = EndP.longitude;
    double dLat = math.radians(lat2 - lat1);
    double dLon = math.radians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(math.radians(lat1)) *
            cos(math.radians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * asin(sqrt(a));
    return Radius * c;
  }

  void _onMarkerTapped(MarkerId markerId) {
    Marker tappedMarker;
    int i = 0;
    for (; i < markers.length; i++) {
      if (markerId == markers.elementAt(i).markerId) {
        tappedMarker = markers.elementAt(i);
        break;
      }
    }
    if (tappedMarker != null) {
      showAlertDialog(i);
    }
  }

  showAlertDialog(index) {
    // set up the buttons
    Widget launchButton = FlatButton(
      child: Text("Go And Get IT!"),
      onPressed: () {
        setState(() {
          chosedMarker = markers[index];
          print('LatLng ${markers.length}');
          markers.clear();
          print('LatLng ${markers.length}');
        });
        markers.add(chosedMarker);
        following = true;
        Navigator.of(context).pop();
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () async {
        await deleteMarker(markers[index].markerId.value);
        setState(() {});
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    print('LatLng ${userLocation.getLatLng()} , ${markers[index].position}');
    AlertDialog alert = AlertDialog(
      title: Text("${markers[index].infoWindow.title}"),
      content: Text('${(CalculationByDistance(userLocation.getLatLng(), markers[index].position) * 1000).toStringAsFixed(2)} meter to get it'
        +'\n${markers[index].infoWindow.snippet}'
        ,
      ),
      actions: [
        launchButton,
        cancelButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<GoogleMap> getGoogleMap() async {
    Completer<GoogleMapController> _controller = Completer();
    if (userLocation.getLatLng() == null) {
      await userLocation.getUserLocation();
    }

    following ? 1 : markers = await getMarkers();
    print('markers ${markers.length}');
    for (int i = 0; i < markers.length; i++) {
      markers[i] = markers.elementAt(i).copyWith(onTapParam: () {
        _onMarkerTapped(markers.elementAt(i).markerId);
      });
    }
    return googleMap = GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
          target: LatLng(userLocation.getLatLng().latitude,
              userLocation.getLatLng().longitude),
          zoom: 18),
      markers: Set<Marker>.of(markers),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      tiltGesturesEnabled: true,
      mapToolbarEnabled: true,
    );
  }

  Widget showGoogleMap() {
    return FutureBuilder<GoogleMap>(
      future: getGoogleMap(),
      builder: (BuildContext context, AsyncSnapshot<GoogleMap> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return googleMap;
        } else if (snapshot.error != null) {
          return Container(
            alignment: Alignment.center,
            child: Text(
                'Error Showing Google map, Please Restart ${snapshot.error}'),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: CupertinoActionSheet(
              title: Text('Loading'),
              actions: [
                CupertinoActivityIndicator(
                  radius: 50,
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget getAcquiringWidget() {
    return FutureBuilder<Widget>(
      future: thanksMessage(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return snapshot.data;
        } else if (snapshot.error != null) {
          return Container(
            alignment: Alignment.center,
            child: Text('Error ${snapshot.error}'),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: Text('Loading'),
          );
        }
      },
    );
  }

  Future<Widget> thanksMessage() async {
    print('thing here');
    if (userLocation.getLatLng() == null) {
      print('thing awaiting userLocation');
      await userLocation.getUserLocation();
    }
    while (CalculationByDistance(
                userLocation.getLatLng(), markers.elementAt(0).position) *
            1000 >
        10) {
      print(
          'thing Calling it ${CalculationByDistance(userLocation.getLatLng(), markers.elementAt(0).position) * 1000}');
      await userLocation.getUserLocation();
    }
    return AlertDialog(
      title: Text("Did you got it?"),
      content: Text(
          'it seems that you are ${num.parse((CalculationByDistance(userLocation.getLatLng(), markers[0].position) * 1000).toStringAsFixed(2))} Meter away from.'),
      actions: [
        FlatButton(
            child: Text("Yes i got it!"),
            onPressed: () {
              setState(() async {
                Toast.show(
                    'Thank You for making the world a better place!', context,
                    duration: 7, backgroundColor: Colors.green);
                await deleteMarker(markers[0].markerId.value);
                following = !following;
                Navigator.popAndPushNamed(context, 'FeedMe');
              });
            }),
        FlatButton(
          child: Text(
            "it's not found!",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            setState(() async {
              Toast.show(
                  'Sorry for wasting your time, but consider that it has gone to its place, Thank you!',
                  context,
                  duration: 7,
                  backgroundColor: Colors.green);
              await deleteMarker(markers[0].markerId.value);
              following = !following;
              Navigator.popAndPushNamed(context, 'FeedMe');
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            Container(
              child: showGoogleMap(),
            ),
            following
                ? Align(
                    alignment: Alignment.topRight,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          following = !following;
                          markers.clear();
                        });
                      },
                      child: Text('Cancel'),
                    ),
                  )
                : Container(),
            following
                ? Align(
                    alignment: Alignment.center,
                    child: getAcquiringWidget(),
                  )
                : Container(),
          ],
        ));
  }
}
