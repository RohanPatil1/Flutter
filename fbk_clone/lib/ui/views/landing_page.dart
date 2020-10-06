import 'file:///G:/MyGithub/Flutter/fbk_clone/lib/ui/shared/palette.dart';
import 'file:///G:/MyGithub/Flutter/fbk_clone/lib/ui/views/login_page.dart';
import 'file:///G:/MyGithub/Flutter/fbk_clone/lib/ui/views/nav_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/fblogo.png",
                color: Palette.facebookBlue,
                scale: 8.0,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 24.0),
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/fb_footer.jpg",
                scale: 2.0,
              ),
            )
          ],
        ));
  }
}

class SplashScreenUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/fblogo.png",
            color: Palette.facebookBlue,
            scale: 8.0,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 24.0),
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            "assets/fb_footer.jpg",
            scale: 2.0,
          ),
        )
      ],
    );
  }
}
