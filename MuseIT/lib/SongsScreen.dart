import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:museit/PlayScreen.dart';
import 'package:museit/styles.dart';
import 'package:museit/main_screen.dart';
import 'package:museit/styles.dart';

class SongsScreen extends StatefulWidget {
  @override
  _SongsScreenState createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller2;
  Animation containerAnimation;
  Animation titleAnimation;
  Animation<Offset> offset;
  ScrollController scrollController;
  double width = 360.0;
  double height = 780.0;
  bool isVerticalDrag = false;
  bool isSongSelected = false;

  @override
  void initState() {
    scrollController = ScrollController();

    _controller =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
    _controller2 =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
    containerAnimation = Tween(begin: height * 0.55, end: height * 0.35)
        .animate(CurvedAnimation(parent: _controller2, curve: Curves.bounceOut))
          ..addListener(() {
            //print(containerAnimation.value);
            setState(() {});
          });

    titleAnimation = Tween(begin: height * 0.45, end: height * 0.20)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
          ..addListener(() {
            print(titleAnimation.value);
            setState(() {});
          });
//          ..addStatusListener((status) {
//            if (status == AnimationStatus.completed) {
//              _controller.reverse();
//            } else if (status == AnimationStatus.dismissed) {
//              _controller.forward();
//            }
//          });

//    offset = Tween<Offset>(begin: Offset(0.0,-0.5), end: Offset(0.0, 1.0))
//        .animate(_controller);

    _controller.forward();
    _controller2.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    width = MediaQuery.of(context).size.width;
//    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: purpleDark,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: AnimatedOpacity(
          duration: Duration(milliseconds: 350),
          opacity: isVerticalDrag ? 0.0 : 1.0,
          child: Container(
            margin: EdgeInsets.all(8.0),
            width: 26.0,
            height: 26.0,
            decoration: BoxDecoration(
              color: purpleLight,
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                  size: 18.0,
                ),
              ),
            ),
          ),
        ),
        title: AnimatedOpacity(
          duration: Duration(milliseconds: 350),
          opacity: isVerticalDrag ? 0.0 : 1.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40.0,
            decoration: BoxDecoration(
                color: purpleLight,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                )),
            child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 16.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 18.0,
                  ),
                )),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: Duration(milliseconds: 650),
            curve: Curves.easeOut,
            top: isVerticalDrag ? 9 : titleAnimation.value,
            left: width * 0.14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, right: 16.0, bottom: 8.0),
                  child: Text(
                    "Ambient",
                    style: title,
                  ),
                ),
                AnimatedOpacity(
                  opacity: isVerticalDrag ? 0.0 : 1.0,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "72 listeners · created by ressems",
                      style: subtiteTitle,
                    ),
                  ),
                  duration: Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 450),
            curve: Curves.easeInOut,
            top: isVerticalDrag ? 0.0 : titleAnimation.value,
            left: isVerticalDrag ? 100 : 20.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Icon(
                FontAwesomeIcons.bolt,
                color: purpleLight,
                size: 33.0,
              ),
            ),
          ),
          AnimatedPositioned(
//            position: offset,
            top: isVerticalDrag ? 95 : containerAnimation.value,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  boxShadow: [
                    isVerticalDrag
                        ? BoxShadow(color: Colors.transparent)
                        : BoxShadow(
                            offset: Offset(5, -12),
                            color: purpleLight,
                            spreadRadius: 5.0,
                            blurRadius: 0.0)
                  ],
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(100.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onVerticalDragUpdate: handleVerticalDragUpdate,
//                  onVerticalDragEnd: handleVerticalEndDrag,
                  //  onVerticalDragDown: handleVerticalDragDown,
                  child: ListView(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      SongTile(
                        image: "assets/7.jpg",
                        title: "Mirage",
                        subtitle: "Else",
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSongSelected = true;
                          });
                        },
                        onDoubleTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return PlayScreen();
                          }));
                        },
//                        child: Hero(
//                          tag: "songtile",
//                          child: SongTile(
//                            image: "assets/1.jpg",
//                            title: "Little Poor Me",
//                            subtitle: "Calvin Harris",
//                          ),
//                        ),
                      child: Container(
                        margin: EdgeInsets.only(left: 46.0),
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Hero(
                              tag: "songtile",
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(48.0),
                                child: Container(
                                  width: 45.0,
                                  height: 45.0,
                                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                                    BoxShadow(
                                        color: Colors.black, spreadRadius: 3.0, blurRadius: 3.0)
                                  ]),
                                  child: Image.asset(
                                    "assets/1.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "Little Poor Me",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "Calvin Harris",
                                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //===================================
                      ),

                      SongTile(
                        image: "assets/2.jpg",
                        title: "Hero",
                        subtitle: "Accoult Club",
                      ),
                      SongTile(
                        image: "assets/3.jpg",
                        title: "New Skin",
                        subtitle: "Flume",
                      ),
                      SongTile(
                        image: "assets/4.jpg",
                        title: "Worry Bout Us",
                        subtitle: "Rosie Love",
                      ),
                      SongTile(
                        image: "assets/5.jpg",
                        title: "Elevator",
                        subtitle: "pussycat dolls",
                      ),
                      SongTile(
                        image: "assets/6.jpg",
                        title: "Floor filter",
                        subtitle: "teens",
                      ),
                      SongTile(
                        image: "assets/7.jpg",
                        title: "Fairy tale",
                        subtitle: "tani braxton",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            duration: Duration(milliseconds: 750),
            curve: Curves.easeOut,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            top: isSongSelected ? height * 0.78 : height * 0.9,
            right: 0.0,
            left: isVerticalDrag ? 0.0 : width * 0.3,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 450),
              curve: Curves.easeInOut,
              height: 100.0,
              width: isVerticalDrag ? width : width * 0.7,
              decoration: BoxDecoration(
                  color: voiletDark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100.0),
                  )),
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                    left: isVerticalDrag ? 45.0 : 55.0,
                    top: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Image.asset("assets/1.jpg"),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Little Poor",
                                style: GoogleFonts.raleway(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Calvie Harris",
                                style: GoogleFonts.raleway(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 350),
                          opacity: isVerticalDrag ? 1.0 : 0.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, right: 8.0),
                            child: Text(
                              "2.0 : 3.16",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 16.0, bottom: 12.0),
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1.2)),
                          child: Center(
                            child: Icon(
                              Icons.pause,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

//
  handleVerticalDragUpdate(DragUpdateDetails dragEndDetails) {
    setState(() {
      isVerticalDrag = true;
    });
    //    double fractionDragged = dragEndDetails.globalPosition.dy / height;
//    print("FractionDragged : " + fractionDragged.toString());
//
//    print("Our VALUE WILL BE===========");
//    //print(containerAnimation.value * fractionDragged);
//    print(0.4 * (containerAnimation.value - 8 * fractionDragged));
//    print("Prev Container Position : " + containerAnimation.value.toString());
////
//    myAnimationValue = 0.4 * (containerAnimation.value - 8 * fractionDragged);
////   myAnimationValue=220;
  }

//  handleVerticalEndDrag(DragEndDetails dragEndDetails) {
//    if (_controller.value >= 0.5) {
//      _controller.forward();
//    } else {
//      _controller.reverse();
//    }
//  }

//  handleVerticalDragDown(DragDownDetails dragDownDetails) {
//    double fractionDragged = dragDownDetails.globalPosition.dy;
//
//    print("Vertical DRAG DOWN : " + fractionDragged.toString());
//    print("Our VALUE WILL BE===========");
//    //print(containerAnimation.value * fractionDragged);
//    print(fractionDragged + myAnimationValue);
////    print("Prev Container Position : " +
////        containerAnimation.value.toString());
////
////    myAnimationValue = 0.7*containerAnimation.value + 5 * fractionDragged;
//////   myAnimationValue=220;
//    setState(() {});
//  }
}

class SongTile extends StatelessWidget {
  final image;
  final title;
  final subtitle;

  const SongTile({Key key, this.image, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 46.0),
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(48.0),
            child: Container(
              width: 45.0,
              height: 45.0,
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Colors.black, spreadRadius: 3.0, blurRadius: 3.0)
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
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
