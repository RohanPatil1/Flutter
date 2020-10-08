import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbk_clone/core/models/user.dart';
import 'package:fbk_clone/core/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../locator.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  User _currUser;

  User get currUser => _currUser;

  Future<bool> isUserLoggedIn() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await populateCurrUser(user);
    return user != null;
  }

  Future populateCurrUser(FirebaseUser firebaseUser) async {
    if (firebaseUser != null) {
      _currUser = await _firestoreService.getUser(firebaseUser.uid);
    }
  }

  Future createAccount(
      {@required String email, @required String password}) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return authResult != null;
    } on AuthException catch (e) {
      if (e.code == "weak-password") {
        return "Password is too weak!";
      } else if (e.code == "email-already-in-use") {
        return "Account Already in use,Try Login!";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future logInUser({@required String email, @required String password}) async {
    try {
      var result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return result != null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
