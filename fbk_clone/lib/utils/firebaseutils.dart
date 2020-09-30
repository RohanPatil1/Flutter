import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtils {
  Future<String> createFbAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
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

  Future<String> logInUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
