import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:museit/SongsScreen.dart';
import 'package:museit/styles.dart';
import 'package:rect_getter/rect_getter.dart';

import 'styles.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey(); //<--Create a key
  Rect rect; //<--Declare field of rect
  @override
  Widget build(BuildContext context) {
    void _onTap() async {
      setState(() => rect = RectGetter.getRectFromKey(
          rectGetterKey)); //<-- set rect to be size of fab
      WidgetsBinding.instance.addPostFrameCallback((_) {
        //<-- on the next frame...
        setState(() => rect = rect.inflate(1.3 *
            MediaQuery.of(context).size.longestSide)); //<-- set rect to be big
        Future.delayed(animationDuration + delay,
            _goToNextPage); //<-- after delay, go to next page
      });
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print(width);
    print(height);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: width * 0.054,
            left: width * 0.5,
            child: Container(
              alignment: Alignment.centerRight,
              child: Image.asset(
                "assets/headphone.png",
                height: 280.0,
                width: 240.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: height * 0.27,
            left: 8.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: Text(
                    "Rohan",
                    style: boldText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Good Moring",
                    style: semiBoldText,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      RectGetter(
                        key: rectGetterKey, //<-- Passing the key

                        child: GestureDetector(
                          onTap: () {
                            _onTap();
                            print("pressed");
                            print(rect);
                          },
                          child: TypeCard(
                            width: 150.0,
                            height: 210.0,
                            color: purpleDark,
                            title: "Ambient",
                            icon: Icon(
                              FontAwesomeIcons.bolt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      TypeCard(
                        width: 150.0,
                        height: 180.0,
                        color: green,
                        title: "Hip Hop",
                        icon: Icon(
                          FontAwesomeIcons.baseballBall,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "FAVOURITE",
                    style: GoogleFonts.raleway(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                SongCard(
                  image: "assets/4.jpg",
                  title: "Far Away Forest",
                  subtitle: "Mother Earth Sounds",
                ),
                SongCard(
                  image: "assets/5.jpg",
                  title: "Electric Relaxation",
                  subtitle: "Mother Earth Sounds",
                )
              ],
            ),
          ),
          _ripple()
        ],
      ),
    );
  }

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: SongsScreen()))
        .then((_) => setState(() => rect = null));
  }

  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: purpleDark,
        ),
      ),
    );
  }
}

class TypeCard extends StatelessWidget {
  final Color color;
  final title;
  final Icon icon;
  final width;
  final height;

  const TypeCard(
      {Key key, this.color, this.title, this.icon, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16.0),
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(
                  color: Colors.black54, spreadRadius: 2, blurRadius: 3.5)
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.ellipsisV,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: icon,
                    ),
                    Text(
                      title,
                      style: semiBoldTextWhite,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class SongCard extends StatelessWidget {
  final image;
  final title;
  final subtitle;

  const SongCard({Key key, this.image, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(48.0),
            child: Container(
              width: 45.0,
              height: 45.0,
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Colors.black, spreadRadius: 2.0, blurRadius: 3.0)
              ]),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}
