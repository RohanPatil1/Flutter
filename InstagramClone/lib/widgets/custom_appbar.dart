import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:luffyvio/screens/create_account_screen.dart';
import 'package:luffyvio/screens/home_screen.dart';

AppBar CustomAppbar(BuildContext context, String title, {hasBackBtn = false}) {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  return AppBar(
    title: Text(
      title,
      style: TextStyle(color: Colors.black),
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.logout,
          color: Colors.white,
        ),
        onPressed: () {
          _googleSignIn.signOut();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        },
      )
    ],
    automaticallyImplyLeading: hasBackBtn ? false : true,
  );
}
