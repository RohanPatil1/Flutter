import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:niravanaz_admin/screens/login_page.dart';
import 'package:niravanaz_admin/screens/upload_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'BeViteReg',
        // primaryColor: Colors.pink,
        // accentColor: Colors.pinkAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return UploadPage();
            }
            return SignIn();
          }),
    );
  }
}
