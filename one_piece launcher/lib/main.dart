import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:launcher_assist/launcher_assist.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var installedApps;
  var wallpaper;
  bool accessToStorage;

  @override
  void initState() {
    // TODO: implement initState
    accessToStorage = false;
    super.initState();

    LauncherAssist.getAllApps().then((var apps) {
      setState(() {
        installedApps = apps;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.grey),
      home: Scaffold(
        body: WillPopScope(
          onWillPop: () => Future(() => false),
          child: Stack(
            children: <Widget>[
              WallpaperContainer(wallpaper: wallpaper),
              installedApps != null
                  ? ForegroundWidget(installedApps: installedApps)
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

////To Retrieve Wallpaper from PhoneStorage
//  Future<bool> handleStoragePermission() async {
//    PermissionStatus strPermissionStatus = await getPermissionStatus();
//  }
//
//  Future<PermissionStatus> getPermissionStatus() async {
//    PermissionStatus permissionStatus = await Permission.storage.isGranted;
//  }
}

class ForegroundWidget extends StatefulWidget {
  const ForegroundWidget({Key key, @required this.installedApps})
      : super(key: key);

  final installedApps;

  @override
  _ForegroundWidgetState createState() => _ForegroundWidgetState();
}

class _ForegroundWidgetState extends State<ForegroundWidget>
    with SingleTickerProviderStateMixin {
  AnimationController animOpacityCtrl;
  Animation<double> opacity;

  @override
  void initState() {
    // TODO: implement initState
    animOpacityCtrl =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    opacity = Tween(begin: 0.0, end: 1.0).animate(animOpacityCtrl);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    animOpacityCtrl.forward();
    return FadeTransition(
      opacity: opacity,
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
        child: GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 40,
          physics: BouncingScrollPhysics(),
          children: List.generate(
              widget.installedApps != null ? widget.installedApps.length : 0,
              (index) {
            return GestureDetector(
              child: Container(
                child: Column(
                  children: <Widget>[
                    IconContainer(index),
                    SizedBox(
                      height: 10,
                      ),
                    Text(
                      widget.installedApps[index]["label"],
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Raleway",
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              onTap: () => LauncherAssist.launchApp(
                  widget.installedApps[index]["package"]),
            );
          }),
        ),
      ),
    );
  }

  Widget IconContainer(index) {
    try {
      return Image.memory(
        widget.installedApps[index]["icon"] != null
            ? widget.installedApps[index]["icon"]
            : Uint8List(0),
        height: 50,
        width: 50,
      );
    } catch (e) {
      print(e);
      return Container();
    }
  }
}

class WallpaperContainer extends StatelessWidget {
  const WallpaperContainer({Key key, @required this.wallpaper})
      : super(key: key);

  final wallpaper;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.black,

          image: DecorationImage(
              image: ExactAssetImage("assets/one_piece.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),

              alignment: Alignment.center)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    );
  }
}
