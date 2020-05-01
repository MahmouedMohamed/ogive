import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'api_callers/get.dart';
import 'api_callers/post.dart';
import 'models/user.dart';

abstract class BaseAuth {
  Future<dynamic> signIn(String email, String password);

  Future<dynamic> signUp(String name, String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification(user);

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<dynamic> signIn(String email, String password) async {
    AuthResult result;
    try {
      result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print('thing $e');
      return null;
    }
    FirebaseUser user = result.user;
    if (user.isEmailVerified) return await getUser(user.uid);
    print('thing $user');
    return 'Email isn\'t verified';
  }

  Future<dynamic> signUp(String name, String email, String password) async {
    AuthResult result;
    try {
      result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print('thing ${e.runtimeType}');
      return e;
    }
    sendEmailVerification(result.user);
    return await register(
        result.user.uid, name, email, password, DateTime.now());
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification(user) async {
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}
