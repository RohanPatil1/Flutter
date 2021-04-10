import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbk_clone/core/models/user.dart';
import 'package:fbk_clone/core/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../locator.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  UserData _currUser;

  UserData get currUser => _currUser;

  Future<bool> isUserLoggedIn() async {
    User user = FirebaseAuth.instance.currentUser;
    await populateCurrUser(user);
    return user != null;
  }

  Future populateCurrUser(User firebaseUser) async {
    if (firebaseUser != null) {
      _currUser = await _firestoreService.getUser(firebaseUser.uid);
    }
  }

  Future createAccount(
      {@required String email, @required String password}) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserData _user = UserData(
          id: authResult.user.uid,
          fullName: "Rohan Patil",
          imgUrl:
              "https://cdn.pixabay.com/photo/2017/05/13/23/05/img-src-x-2310895_960_720.png",
          email: authResult.user.email);

      _currUser = _user;
      await _firestoreService.storeUser(_user);
      // await populateCurrUser(authResult);

      return authResult != null;
    } on FirebaseAuthException catch (e) {
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
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await populateCurrUser(result.user);

      return result != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
