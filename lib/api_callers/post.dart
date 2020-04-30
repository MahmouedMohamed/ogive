import 'package:firebase_database/firebase_database.dart';
final fb = FirebaseDatabase.instance;

Future<bool> register(uid,name,email,password,time) async {
  final ref = fb.reference();
  await ref.child('Users').child(uid).set({'created_at': time.toString() ,'email' : email,'name' : name});
  print('thing final');
  return true;

}