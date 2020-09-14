import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzinga/api_utils/code_vectors_utils.dart';
import 'package:quizzinga/data_model/category_model.dart';
import 'package:quizzinga/repository/utils_repository.dart';
import 'package:quizzinga/screens/category_screen.dart';
import 'package:quizzinga/screens/play_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff1C1B20),
          leading: IconButton(
            icon: Icon(
              Icons.settings,
              color: Color(0xff8691A2),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => SettingsDialog());
            },
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    "assets/images/coin.png",
                    width: 24.0,
                    height: 24.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "400",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8691A2),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(-0.5, -1.0),
              stops: [0.0, 0.5, 0.5, 1],
              colors: [
                Color(0xff191E2A), //red
                Color(0xff191E2A), //red
                Color(0xff1E2331), //orange
                Color(0xff1E2331), //orange
              ],
              tileMode: TileMode.repeated,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 8.0),
                child: Image.asset(
                  "assets/images/logo.PNG",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: width * 0.3,
                width: width * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24.0),
                        bottomRight: Radius.circular(24.0)),
                    color: Color(0xffA3C801),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff465624),
                        spreadRadius: 3.0,
                        offset: Offset(-3.0, 3.0),
                      )
                    ]),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Get Free \n  Coins",
                        style: TextStyle(
                            color: Color(0xff233A00),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      Image.asset(
                        "assets/images/coin.png",
                        width: 40.0,
                        height: 40.0,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlayScreen()),
                  );
                },
                child: Center(
                  child: Container(
                    height: height * 0.08,
                    width: width * 0.6,
                    decoration: BoxDecoration(
                        color: Color(0xffADD101),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff465624),
                            spreadRadius: 1.0,
                            offset: Offset(0.4, 3.0),
                          )
                        ]),
                    child: Center(
                        child: Text(
                      "PLAY",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                              // bottomLeft
                              offset: Offset(-1.5, -1.5),
                              color: Colors.black.withOpacity(0.1)),
                          Shadow(
                              // bottomRight
                              offset: Offset(1.5, -1.5),
                              color: Colors.black.withOpacity(0.1)),
                          Shadow(
                              // topRight
                              offset: Offset(1.5, 1.5),
                              color: Colors.black.withOpacity(0.1)),
                          Shadow(
                              // topLeft
                              offset: Offset(-1.5, 1.5),
                              color: Colors.black.withOpacity(0.1)),
                        ],
                      ),
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoryScreen()),
                    );
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                        color: Color(0xffD7D7D5),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff888988),
                            spreadRadius: 1.0,
                            offset: Offset(0.4, 3.0),
                          )
                        ]),
                    child: Center(
                        child: Text(
                      "Categories",
                      style: TextStyle(
                        color: Color(0xff7A7C7E),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class SettingsDialog extends StatefulWidget {
  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  bool playSound = false;
  final assetsAudioPlayer = AssetsAudioPlayer();

  void _playSound() async {
    assetsAudioPlayer.open(
      Audio("assets/audio/music.mp3"),
    );
    assetsAudioPlayer.play();

//    AssetsAudioPlayer.newPlayer().open(
//      Audio("assets/audios/song1.mp3"),
//
//      showNotification: true,
//    );
  }

  void _stopSound() {
    assetsAudioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Color(0xff1C1B20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                        width: 20.0,
                      ),
                      Center(
                        child: Text(
                          "Settings",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xff87909E)),
                          child: Icon(
                            Icons.close,
                            color: Color(0xff2B2D38),
                            size: 16.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  color: Color(0xff343849),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.touch_app,
                          color: Color(0xff8490A1),
                        ),
                        title: Text(
                          "Button Sound",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Switch(
                          focusColor: Color(0xffA0CD3C),
                          hoverColor: Color(0xffA0CD3C),
                          inactiveThumbColor: Colors.grey,
                          activeColor: Color(0xffA0CD3C),
                          value: true,
                          onChanged: (bool value) {},
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.touch_app,
                          color: Color(0xff8490A1),
                        ),
                        title: Text(
                          "Effect Sound",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Switch(
                          focusColor: Color(0xffA0CD3C),
                          hoverColor: Color(0xffA0CD3C),
                          inactiveThumbColor: Colors.grey,
                          activeColor: Color(0xffA0CD3C),
                          value: true,
                          onChanged: (bool value) {},
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.music_note,
                          color: Color(0xff8490A1),
                        ),
                        title: Text(
                          "Music",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Switch(
                          focusColor: Color(0xffA0CD3C),
                          hoverColor: Color(0xffA0CD3C),
                          inactiveThumbColor: Colors.grey,
                          activeColor: Color(0xffA0CD3C),
                          value: playSound,
                          onChanged: (bool value) {
                            setState(() {
                              playSound = value;
                              if (playSound) {
                                print(
                                    "PLAY SOUND================================");
                                _playSound();
                              } else {
                                print(
                                    "STOP SOUND================================");
                                _stopSound();
                              }
                            });
                          },
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.note,
                          color: Color(0xff8490A1),
                        ),
                        title: Text(
                          "Privacy Policy",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff8490A1),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: Color(0xff8490A1),
                        ),
                        title: Text(
                          "About",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff8490A1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                        child: Text(
                          "Version 0.8.2+12 ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
