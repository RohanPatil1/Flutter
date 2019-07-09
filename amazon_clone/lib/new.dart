import 'package:flutter/material.dart';
import 'db/user.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/home.dart';

enum Status { Uninitialised, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _firebaseAuth;
  FirebaseUser _firebaseUser;
  UserServices userServices = UserServices();
  Status _status = Status.Unauthenticated;

  //Getter Methods
  Status get status => _status;

  FirebaseUser get user => _firebaseUser;

  UserProvider.initalise() : _firebaseAuth = FirebaseAuth.instance {
    _firebaseAuth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> siginIN(String email, String password,BuildContext context) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> siginUP(
      String name, String email, String password, BuildContext context) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        Map<String, dynamic> values = {
          "name": name,
          "email": email,
          "userId": user.uid
        };
        userServices.createUser(values);
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _firebaseAuth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(FirebaseUser user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _firebaseUser = user;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
