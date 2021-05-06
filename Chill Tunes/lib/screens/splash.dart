import 'package:chill_sounds/screens/appBackGround.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool run = true;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _initPlayer();
    super.initState();
  }

  void _initPlayer() {
    try {
      _videoPlayerController =
          VideoPlayerController.asset('assets/videos/vsplash3.mkv');
      _videoPlayerController.play();
      _videoPlayerController.initialize().then((value) => {


          _videoPlayerController.addListener(() {
        setState(() {
          if (!_videoPlayerController.value.isPlaying &&
              _videoPlayerController.value.isInitialized &&
              (_videoPlayerController.value.duration ==
                  _videoPlayerController.value.position)) {
            print("VIDEO FINISHED");
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return AppBackground();
              },
            ));
            setState(() {});
          }
        });
      })
    });
    } catch (Exception) {
    print(Exception);
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181818),
      body: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _videoPlayerController.value.size.width,
            height: _videoPlayerController.value.size.height,
            child: ClipRect(
              child: VideoPlayer(_videoPlayerController),
              // clipper: RectClipper(),
            ),
          ),
        ),
      ),
    );
  }
}
