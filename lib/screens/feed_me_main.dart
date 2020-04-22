import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ogive/api_callers/delete.dart';
import 'package:ogive/api_callers/get.dart';
import 'package:ogive/models/user_location.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart';

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
  @override
  void initState() {
    super.initState();
    userLocation = new UserLocation();
  }

//  initMarkers() async {
//    markers = await getMarkers();
//  }

  changeColor(index) {
    print('Finding Changing color of ${markers[index].markerId}');
    markers[index] = markers[index].copyWith(
        iconParam:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
  }

  double CalculationByDistance(LatLng StartP, LatLng EndP) {
    int Radius = 6371; // radius of earth in Km
    double lat1 = StartP.latitude;
    double lat2 = EndP.latitude;
    double lon1 = StartP.longitude;
    double lon2 = EndP.longitude;
    double dLat = radians(lat2 - lat1);
    double dLon = radians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(radians(lat1)) * cos(radians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
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
      onPressed: () async{
        await deleteMarker(markers[index].markerId.value);
        setState(()  {
        });
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    print('LatLng ${userLocation.getLatLng()} , ${markers[index].position}');
    AlertDialog alert = AlertDialog(
      title: Text("${markers[index].markerId}"),
      content: Text(
          '${(CalculationByDistance(userLocation.getLatLng(), markers[index].position) * 1000).toString()}'),
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
            child: Text('Loading'),
          );
        }
      },
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
            Visibility(
                visible: following,
                child: Align(
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
                ))
          ],
        ));
  }
}
