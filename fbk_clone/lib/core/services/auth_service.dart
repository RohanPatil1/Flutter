import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> isUserLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    return user != null;
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
