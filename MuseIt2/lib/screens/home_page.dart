import 'dart:math';
import 'dart:ui';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import 'package:muse_itv2/constants/colors_utils.dart';
import 'package:muse_itv2/util/video_clipper.dart';

import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  VideoPlayerController _controller;
  VideoPlayerController _controller2;
  AnimationController animationController;
  Animation containerAnimation;
  Animation bottomSheetAnimation;
  double height = 0.0;
  var rng = new Random();
  final List<double> values = [];

  static final AlignmentGeometry _beginAlignment = Alignment.topLeft;
  static final AlignmentGeometry _endAlignment = Alignment.bottomRight;

  static LinearGradient buildGradient(
          AlignmentGeometry begin, AlignmentGeometry end, List<Color> colors) =>
      LinearGradient(begin: begin, end: end, colors: colors);
  static LinearGradient rainbowBlue2 = buildGradient(
      _beginAlignment, _endAlignment, const [Color(0xffFF0763), Colors.white]);

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);

    containerAnimation = Tween(begin: 0.0, end: -120.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 0.55, curve: Curves.easeInExpo)))
      ..addListener(() {
        setState(() {});
      });
    bottomSheetAnimation = Tween(begin: -780.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.6, 1.0, curve: Curves.easeInOut)))
      ..addListener(() {
        setState(() {});
      });

    _controller = VideoPlayerController.asset('assets/video/video5.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        _controller.setPlaybackSpeed(0.7);
        setState(() {});
      });
    _controller2 = VideoPlayerController.asset('assets/video/gradient2.m4v')
      ..initialize().then((_) {
        _controller2.setLooping(true);
      });

    for (var i = 0; i < 100; i++) {
      values.add(rng.nextInt(70) * 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 550.0,
                  backgroundColor: Colors.black,
                  stretch: true,
                  title: GestureDetector(
                      onTap: () {
                        if (animationController.isCompleted) {
                          animationController.reverse();
                        } else {
                          animationController.forward();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 28.0, left: 8),
                        child: Text(
                          "Discover",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "CenturyGothicBI"),
                        ),
                      )),
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: [
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                      StretchMode.fadeTitle
                    ],
                    background: Stack(
                      children: [
                        Transform.rotate(
                          //angle: -math.pi,
                          angle: 0,
                          child: SizedBox.expand(
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: _controller.value.size?.width ?? 0,
                                height: _controller.value.size?.height ?? 0,
                                child: ClipRect(
                                  child: VideoPlayer(_controller),
                                  clipper: RectClipper(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Playlist - Trending Music",
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 16.0,
                                    fontFamily: "CenturyGothicR",
                                  ),
                                ),
                                Text(
                                  "This is what's trending today",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40.0,
                                      fontFamily: "CenturyGothicBI"),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 114,
                          height: 50.0,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Container(
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white38,
                                        spreadRadius: 0.5,
                                        blurRadius: 0.8)
                                  ],
                                  color: pinkColor,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(18.0),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      "PLAY",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "CenturyGothicBI",
                                          fontSize: 12.0),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 60,
                                top: 0,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          color: pinkColor, width: 1.4)),
                                  child: Center(
                                    child: Icon(Icons.play_arrow,
                                        color: Color(0xffFF0763)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: maroonColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Icon(
                                FeatherIcons.bookmark,
                                color: Colors.white,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: maroonColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Icon(
                                FeatherIcons.share2,
                                color: Colors.white,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 36.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Spotlight On",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Calibri",
                                fontSize: 16.0),
                          ),
                          Text(
                            "Browse All",
                            style: TextStyle(
                                color: pinkColor,
                                fontFamily: "Calibri",
                                fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                    Container(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            PageViewItemT1(
                              asset: "assets/images/6.jpg",
                            ),
                            PageViewItemT1(
                              asset: "assets/images/4.jpg",
                            ),
                            PageViewItemT1(
                              asset: "assets/images/3.jpg",
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 18.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Most Popular",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Calibri",
                                fontSize: 16.0),
                          ),
                          Text(
                            "Browse All",
                            style: TextStyle(
                                color: pinkColor,
                                fontFamily: "Calibri",
                                fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              height: 50,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: pinkColor),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    "assets/images/5.jpg",
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            title: Text(
                              "What's Going On Remixes Comp...",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "CenturyGothicB",
                                  fontSize: 15.0),
                            ),
                            subtitle: Text(
                              "Ren Xue",
                              style: TextStyle(
                                  color: Colors.white38,
                                  fontFamily: "CenturyGothicR",
                                  fontSize: 12.0),
                            ),
                            trailing: Icon(
                              Icons.more_horiz_outlined,
                              color: Colors.white60,
                            ),
                          );
                        },
                      ),
                    )
                  ]),
                )
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
            left: 0,
            right: 0,
            bottom: containerAnimation.value,
            child: GestureDetector(
              onTap: () {
                animationController.forward();
                _controller2.play();
                //_controller1.pause();

                setState(() {});
              },
              child: ClipRect(
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: 6.0,
                    sigmaY: 6.0,
                  ),
                  child: Container(
                    height: 140.0,
                    color: Colors.grey.withOpacity(0.34),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            // color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Rosie Love How'd You Like It",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.0),
                                        ),
                                        Text(
                                          "Detective Aimbert",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 8.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          height: 10.0,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black.withOpacity(0.3),
                          child: GradientProgressIndicator(
                            gradient: rainbowBlue2,
                            value: 0.6,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BottomIcon(
                                icon: Icon(
                                  FeatherIcons.music,
                                  color: Colors.red,
                                ),
                                title: "Discover",
                                isSelected: true,
                              ),
                              BottomIcon(
                                icon: Icon(
                                  FeatherIcons.search,
                                  color: Colors.white54,
                                ),
                                title: "Search",
                                isSelected: false,
                              ),
                              BottomIcon(
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white54,
                                ),
                                title: "Library",
                                isSelected: false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            left: 0,
            right: 0,
            bottom: bottomSheetAnimation.value,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller2.value.size?.width ?? 0,
                        height: _controller2.value.size?.height ?? 0,
                        child: VideoPlayer(_controller2),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 24.0, bottom: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _controller2.pause();
                                    _controller.play();
                                    setState(() {});
                                    animationController.reverse();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: maroonColor.withOpacity(0.35),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 14.0,
                                            left: 8.0,
                                            right: 8.0),
                                        child: Transform.rotate(
                                          angle: -math.pi / 2,
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.white,
                                            size: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "PLAYLIST",
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12.0,
                                            fontFamily: "CenturyGothicR",
                                            letterSpacing: 0.9),
                                      ),
                                      Text(
                                        "Trending Favs Playlist",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontFamily: "CenturyGothicBI"),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.more_horiz_outlined,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 230,
                            child: PageView(
                              controller: PageController(
                                viewportFraction: 0.925,
                                initialPage: 0,
                              ),
                              physics: ClampingScrollPhysics(),
                              children: [
                                PageViewItemT2(
                                  asset: "assets/images/5.jpg",
                                ),
                                PageViewItemT2(
                                  asset: "assets/images/4.jpg",
                                ),
                                PageViewItemT2(
                                  asset: "assets/images/2.jpg",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "Deep Purple",
                            style: TextStyle(
                                color: pinkColor,
                                fontFamily: "CenturyGothicB",
                                fontSize: 16.0),
                          ),
                          Text(
                            "Sometimes I Feel Like \n  Screaming",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Calibri",
                                fontSize: 20.0),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: 250.0,
                                  width: 250.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      // color: purple2.withOpacity(0.3),
                                      boxShadow: [
                                        BoxShadow(
                                            color: pinkColor.withOpacity(0.2),
                                            spreadRadius: 6.6,
                                            blurRadius: 5.4),
                                      ],
                                      border: Border.all(
                                          color: Colors.red.withOpacity(0.5),
                                          width: 5.5)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.skip_previous_outlined,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: pinkColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Icon(
                                              Icons.pause_rounded,
                                              color: Colors.white,
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.skip_next_outlined,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   left: 35,
                              //   top: -20,
                              //   child: SizedBox(
                              //     width: 290.0,
                              //     height: 290.0,
                              //     child: GradientCircularProgressIndicator(
                              //       gradient: rainbowBlue2,
                              //     ),
                              //
                              //     // child: CircularProgressIndicator(
                              //     //   strokeWidth: 9,
                              //     //   value: 0.20,
                              //     //   valueColor:
                              //     //       AlwaysStoppedAnimation(pinkColor),
                              //     //   backgroundColor: Colors.transparent,
                              //     // ),
                              //   ),
                              // ),
                              Center(
                                child: Container(
                                  height: 250.0,
                                  width: 250.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 9,
                                    value: 0.20,
                                    valueColor:
                                        AlwaysStoppedAnimation(pinkColor),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 280,
                                top: 66,
                                child: Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Center(
                                    child: Container(
                                      width: 10.0,
                                      height: 10.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: pinkColor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FeatherIcons.shuffle,
                                color: Colors.white,
                                size: 15.0,
                              ),
                              Icon(
                                FeatherIcons.repeat,
                                color: Colors.white,
                                size: 15.0,
                              ),
                              Icon(
                                Icons.playlist_add,
                                color: Colors.white,
                                size: 15.0,
                              ),
                              Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 15.0,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 28.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.perm_device_info,
                                color: Colors.white,
                                size: 15.0,
                              ),
                              Text(
                                "Device Available",
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 12.0),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )

          //   LoginWidget()
        ],
      ),
    );
  }
}

class BottomIcon extends StatelessWidget {
  final Icon icon;
  final String title;
  final bool isSelected;

  const BottomIcon({Key key, this.icon, this.title, this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        SizedBox(
          height: 4.0,
        ),
        Text(
          title,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.white38,
              fontSize: 10.0),
        )
      ],
    );
  }
}

class PageViewItemT2 extends StatelessWidget {
  final String asset;

  const PageViewItemT2({Key key, this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            asset,
            fit: BoxFit.cover,
          )),
    );
  }
}

class PageViewItemT1 extends StatelessWidget {
  final String asset;

  const PageViewItemT1({Key key, this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120.0,
            width: 180,
            decoration: BoxDecoration(
              color: pinkColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  asset,
                  fit: BoxFit.cover,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              "What's going on",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "CenturyGothicB",
                  fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Aerosmith",
              style: TextStyle(
                  color: Colors.white54,
                  fontFamily: "CenturyGothicB",
                  fontSize: 14.0),
            ),
          )
        ],
      ),
    );
  }
}
