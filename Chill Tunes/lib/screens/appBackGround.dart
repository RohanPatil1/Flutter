import 'dart:ui';

import 'package:chill_sounds/data/audioBrain.dart';
import 'package:chill_sounds/data/nightMode.dart';
import 'package:chill_sounds/widgets/lottieButton.dart';
import 'package:chill_sounds/widgets/mixerSoundTile.dart';
import 'package:chill_sounds/widgets/sldingUpPanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'favorite.dart';
import 'home.dart';

class AppBackground extends StatefulWidget {
  @override
  _AppBackgroundState createState() => _AppBackgroundState();
}

class _AppBackgroundState extends State<AppBackground> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isPanelOpened = false;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  showTimerPick() async {
    // DateTime pickedDate = DateTime.now();
    // DatePicker.showTime12hPicker(context, showTitleActions: true,
    //         onChanged: (date) {
    //   print('change $date');
    // }, onConfirm: (date) {
    //   print('confirm $date');
    //   setState(() {
    //     pickedDate = date;
    //     diff = pickedDate.difference(DateTime.now()).inMilliseconds;
    //     isTimerRunning = true;
    //     print("DIFFF ${pickedDate.difference(DateTime.now()).inMilliseconds}");
    //   });
    // }, currentTime: DateTime.now(), locale: LocaleType.en)
    //     .then((value) => {
    //           if (diff > 0)
    //             {
    //               Future.delayed(Duration(milliseconds: diff), () {
    //                 Provider.of<AudioBrain>(context).pauseAllAudio();
    //               })
    //             }
    //         });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(-1.0, -0.5),
                    end: Alignment(1.0, 0.8),
                    //         begin: Alignment.bottomRight, stops: [
                    //   0.1,
                    //   0.9
                    // ],
                    colors: [
                  // Color(0xff0071da),
                  //    Color(0xfffdc8f1),

                  Color(0xff332afc),
                  Color(0xfffdc8f1),

                  //Colors.tealAccent,
                  // Color(0xffFFD5EA),

                  // Color(0xff011730),
                  // Color(0xff006cd2),

                  // Color(0xff332afc),
                  // Color(0xfffdc8f1),
                ])),
          ),

          /// background image

          Container(
            margin: EdgeInsets.only(top: 32),
            width: MediaQuery.of(context).size.width,
            height: 240.0,
            // child: Image.asset(
            //   "assets/background/bgP.png",
            //   fit: BoxFit.fill,
            // ),
            child: SvgPicture.asset(
              'assets/background/bgS.svg',
              fit: BoxFit.fill,
            ),
          ),
          // SvgPicture.asset(
          //             'assets/background/${Provider.of<NightMode>(context).isNight ? 'night' : 'day'}.svg',
          //             fit: BoxFit.cover,
          //           ),

          /// home body
          GestureDetector(
            onTap: () async {
              await Provider.of<AudioBrain>(context, listen: false)
                  .slideUpCtrl
                  .show();
            },
            child: isFavorite
                ? Favorite(
                    onBack: () {
                      setState(() {
                        isFavorite = false;
                      });
                    },
                  )
                : Home(
                    onFavourite: () {
                      setState(() {
                        isFavorite = true;
                      });
                    },
                    onDrawerTap: () =>
                        _scaffoldKey.currentState!.openEndDrawer(),
                  ),
          ),

          Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                "assets/background/tree.png",
                width: 240.0,
                fit: BoxFit.fill,
              )),

          /// sliding panel
          SlidingUpPanel(
            isDraggable: false,
            boxShadow: null,
            onPanelSlide: (position) {
              setState(() {
                if (position < 0.3)
                  isPanelOpened = false;
                else
                  isPanelOpened = true;
              });
            },
            // onPanelClosed: () {
            //   setState(() {
            //     isPanelOpened = false;
            //   });
            // },
            // onPanelOpened: () {
            //   setState(() {
            //     isPanelOpened = true;
            //   });
            // },
            controller: Provider.of<AudioBrain>(context).slideUpCtrl,
            color: Colors.transparent,
            maxHeight: MediaQuery.of(context).size.height * 0.5,
            minHeight: MediaQuery.of(context).size.height * 0.09,
            panelBuilder: (scrollController) {
              return ClipRect(
                child: BackdropFilter(
                  filter: Provider.of<NightMode>(context).isNight
                      ? ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0)
                      : ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.6,
                        color: Colors.white.withOpacity(
                            Provider.of<NightMode>(context).isNight
                                ? 1.0
                                : 0.8),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      gradient: !isPanelOpened
                          ? null
                          : Provider.of<NightMode>(context).isNight
                              ? LinearGradient(
                                  begin: Alignment(0.0, -1.0),
                                  end: Alignment(0.0, 1.0),
                                  colors: [
                                    const Color(0x001e2773),
                                    const Color(0x002f0352)
                                  ],
                                  stops: [0.0, 1.0],
                                )
                              : LinearGradient(
                                  begin: Alignment(0.0, -1.0),
                                  end: Alignment(0.0, 1.0),
                                  colors: [
                                    Colors.white54.withOpacity(0.1),
                                    Colors.white70.withOpacity(0.3),
                                    // const Color(0x6438486e),
                                    // const Color(0x8a3d4f77)
                                  ],
                                  stops: [0.0, 1.0],
                                ),
                    ),
                    // duration: Duration(milliseconds: 300),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            Provider.of<AudioBrain>(context, listen: false)
                                .onTapMenu(context);
                          },
                          child: Row(
                            children: [
                              AudioBrain.sounds.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Icon(
                                        Icons.queue_music_rounded,
                                        color: Colors.white,
                                        size: 28.0,
                                      ),
                                    )
                                  : LottieButton(
                                      key: AudioBrain.key,
                                      width: 54,
                                      height: 54,
                                      path: 'assets/icons/playPause.json',
                                      start: 0,
                                      end: 0.5,
                                      onTap: (value) {
                                        AudioBrain().pauseAllAudio();
                                      },
                                    ),
                              // IconButton(
                              //         icon: Provider.of<AudioBrain>(context,
                              //                     listen: false)
                              //                 .isAnyAudioPlaying
                              //             ? Icon(
                              //                 Icons.stop,
                              //                 size: 28.0,
                              //                 color: Colors.white,
                              //               )
                              //             : Icon(
                              //                 Icons.play_arrow,
                              //                 size: 28.0,
                              //                 color: Colors.white,
                              //               ),
                              //         onPressed: () {
                              //           print("PAUSING ALL AUDIOs");
                              //           Provider.of<AudioBrain>(context,
                              //                   listen: false)
                              //               .pauseAllAudio();
                              //         },
                              //       ),
                              Spacer(),
                              // LottieButton(
                              //   path: 'assets/icons/favorite.json',
                              //   start: 0.5,
                              //   end: 1.0,
                              //   onTap: (value) {
                              //     print('isFavorite = $value');
                              //   },
                              // ),
                              SizedBox(width: 10),
                              InkWell(
                                child: SvgPicture.asset(
                                  // ToDo: handle is timer running
                                  'assets/icons/stopwatch.svg',
                                  // 'assets/icons/stopwatch${isTimerRunning ? '' : '_outline'}.svg',
                                  color: Colors.white,
                                  width: 25,
                                  height: 25,
                                ),
                                onTap: () async {
                                  showTimerPick();
                                },
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                        SizedBox(),
                        (AudioBrain.sounds.isEmpty)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 200.0,
                                        height: 180.0,
                                        child: Image.asset(
                                          'assets/icons/wave.png',
                                          color: Colors.white,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text(
                                        "Add tunes...",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'PoppinsSB',
                                          fontSize: 24.0,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 8.0,
                                              color: Colors.white
                                                  .withOpacity(0.25),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Text(""),
                        Expanded(
                          child: ListView.builder(
                            itemCount: AudioBrain.sounds.length,
                            itemBuilder: (context, index) {
                              return MixerSoundTile(
                                  sound: AudioBrain.sounds[index]);
                            },
                            controller: scrollController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )

          // ,Align(
          //   alignment: Alignment.topLeft,
          //   child: SafeArea(
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Image.asset(
          //         'assets/icons/logo3.png',
          //         width: 68.0,
          //         height: 68.0,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
