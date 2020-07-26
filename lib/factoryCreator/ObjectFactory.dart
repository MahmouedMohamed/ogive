import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ogive/models/like.dart';
import 'package:ogive/models/memory.dart';
import 'package:ogive/models/user.dart';
import 'package:ogive/models/weather.dart';

class ObjectFactory {
  User getUserFromJson(json) {
    return new User(
      json['user']['id'].toString(),
      json['user']['name'],
      json['user']['user_name'],
      json['user']['email'],
      json['user']['email_verified_at'] == null
          ? null
          : DateTime.parse(json['user']['email_verified_at']),
      DateTime.parse(json['user']['created_at']),
      DateTime.parse(json['user']['updated_at']),
    );
  }

  getMarkerColor(priority) {
    switch (priority) {
      case 1:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 3:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case 5:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
      case 7:
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange);
      case 10:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }

  List<Marker> getMarkersFromJson(json) {
//  MarkerIcon markerOption = new MarkerIcon();      ///for custom marker icon
    List<Marker> returnedMarkers = new List<Marker>();
    json['markers'].forEach((marker) {
      returnedMarkers.add(Marker(
        markerId: new MarkerId(marker['id'].toString()),
        position: LatLng(double.parse(marker['Latitude'].toString()),
            double.parse(marker['Longitude'].toString())),
//      icon: markerOption.getIcon(),
        icon: getMarkerColor(marker['food']['priority']),
        infoWindow: InfoWindow(
            title: marker['food']['name'],
            snippet: marker['food']['description'] +
                ' \nQuantity = ${marker['food']['quantity']}'),
      ));
    });
    return returnedMarkers;
  }

  Weather getWeatherFromJson(json, userLocation) {
    return new Weather(
      json['name'].toString(),
      userLocation.latitude,
      userLocation.longitude,
      json['weather'][0]['main'].toString().toLowerCase(),
      json['weather'][0]['description'],
      double.parse(json['main']['temp'].toString()) - 273.15,
      double.parse(json['main']['temp_min'].toString()) - 273.15,
      double.parse(json['main']['temp_max'].toString()) - 273.15,
      double.parse(json['main']['pressure'].toString()),
      double.parse(json['main']['humidity'].toString()),
      double.parse(json['wind']['speed'].toString()),
    );
  }

  List<Memory> getMemoriesFromJson(json) {
    List returnedMemories = new List<Memory>();
    json['memories'].forEach((memory) {
      List likes = new List<Like>();
      if (memory['likes'] != null) {
        likes = getLikesFromJson(memory['likes']);
      }
      returnedMemories.add(
        new Memory(
            memory['id'].toString(),
            memory['user_id'].toString(),
            memory['person_name'].toString(),
            DateTime.parse(memory['birth']),
            DateTime.parse(memory['death']),
            memory['life_story'].toString(),
            memory['image'].toString(),
            likes),
      );
    });
    return returnedMemories;
  }

  List<Like> getLikesFromJson(json) {
    List returnedLikes = new List<Like>();
    json.forEach((like) {
      returnedLikes.add(new Like(
        like['memory_id'].toString(),
        like['user_id'].toString(),
      ));
    });
    return returnedLikes;
  }
}
