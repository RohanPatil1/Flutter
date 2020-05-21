import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:museit/styles.dart';

class PlayScreen extends StatefulWidget {
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller2;
  Animation containerAnimation;
  double width;
  double height;

  @override
  void initState() {
    width = 360.0;
    height = 780.0;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));

    _controller2 =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);

    containerAnimation = Tween(begin: height * 0.45, end: height * 0.15)
        .animate(CurvedAnimation(parent: _controller2, curve: Curves.easeInOut))
          ..addListener(() {
            //print(containerAnimation.value);
            setState(() {});
          });

    _controller.repeat();
//    _controller2.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    width = MediaQuery.of(context).size.width;
//    height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          color: voiletDark,
          child: Container(
            margin: EdgeInsets.only(top: 36.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.white60, width: 0.3)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey,
                          size: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Ambient",
                      style: GoogleFonts.raleway(
                          textStyle: Theme.of(context).textTheme.display1,
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
        Positioned(
          // top: containerAnimation.value,
          top: height * 0.15,
          left: 0.0,
          right: 0.0,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70.0),
                    topLeft: Radius.circular(70.0))),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 16.0),
                      width: 250.0,
                      height: 250.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Color(0xffdfdfdf), width: 3.5),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: RotationTransition(
                              turns: _controller,
                              child: Hero(
                                tag: "songtile",
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black54,
                                            spreadRadius: 2.0,
                                            blurRadius: 7.0)
                                      ]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(100.0)),
                                    child: Image.asset(
                                      "assets/1.jpg",
                                      width: 190.0,
                                      height: 190.0,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              width: 250.0,
                              height: 250.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 9,
                                value: 0.20,
                                valueColor: AlwaysStoppedAnimation(purpleLight),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  "Little Poor Me",
                  style: GoogleFonts.raleway(
                      textStyle: Theme.of(context).textTheme.display1,
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Calvin Harris",
                  style: GoogleFonts.raleway(
                      textStyle: Theme.of(context).textTheme.display1,
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 100.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.backward,
                      color: Colors.black,
                      size: 24.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: Container(
                        width: 55.0,
                        height: 55.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: purpleLight,
                        ),
                        child: Center(
                          child: Icon(
                            FontAwesomeIcons.pause,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      FontAwesomeIcons.forward,
                      color: Colors.black,
                      size: 24.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 60.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.bookmark,
                      color: Colors.black.withOpacity(0.7),
                      size: 24.0,
                    ),
                    Icon(
                      FontAwesomeIcons.random,
                      color: Colors.black.withOpacity(0.7),
                      size: 24.0,
                    ),
                    Icon(
                      Icons.repeat,
                      color: Colors.black.withOpacity(0.7),
                      size: 24.0,
                    ),
                    Icon(
                      Icons.playlist_add,
                      color: Colors.black.withOpacity(0.7),
                      size: 24.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: height * 0.26,
          left: width * 0.79,
          child: Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: purpleLight,
                boxShadow: [
                  BoxShadow(
                      color: purpleLight, spreadRadius: 3.0, blurRadius: 5.0)
                ]),
            child: Center(
              child: Container(
                width: 8.0,
                height: 8.0,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              ),
            ),
          ),
        ),
//        Positioned(
//          top: height * 0.30,
//          left: width * 0.45,
//          child: Container(
//            width: 30.0,
//            height: 30.0,
//            decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color: Colors.white
//            ),
//
//          ),
//        )
      ],
    );
  }
}
