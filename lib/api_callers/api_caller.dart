import 'package:ogive/factoryCreator/ObjectFactory.dart';

String url = 'http://192.168.1.8:8000/api/';
ObjectFactory factory = new ObjectFactory();

abstract class ApiCaller{
  dynamic get({oAuthToken,userData,markerData,memoryData,jobData,newsData});
  dynamic create({oAuthToken,userData,markerData,memoryData});
  dynamic update({oAuthToken,userData,markerData,memoryData});
  dynamic delete({oAuthToken,userData,markerData,memoryData});
}