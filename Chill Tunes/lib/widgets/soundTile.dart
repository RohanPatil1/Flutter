import 'dart:io';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:chill_sounds/data/audioBrain.dart';
import 'package:chill_sounds/data/dataBox.dart';
import 'package:chill_sounds/data/modal.dart';
import 'package:chill_sounds/data/nightMode.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math' as maths;

class SoundTile extends StatefulWidget {
  final Sound sound;
  final bool isConnectedToNetwork;

  const SoundTile(
      {Key? key, required this.sound, required this.isConnectedToNetwork})
      : super(key: key);

  @override
  _SoundTileState createState() => _SoundTileState();
}

class _SoundTileState extends State<SoundTile> {
  late AudioPlayer audioPlayer;

  bool isDownloading = false;

  double soundDownloadProgress = 0.0;
  double imageDownloadProgress = 0.0;

  @override
  void initState() {
    super.initState();
    audioPlayer = widget.sound.audioPlayer;
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);
  }

  void playSound() async {
    AudioBrain().addRemoveSound(widget.sound);

    if (widget.sound.isSelected) {
      final audioPath = Data.stringBox.get(widget.sound.sound);
      print('Audio Path = $audioPath');
      if (audioPath != null) {
        int r =
            await audioPlayer.play(audioPath, isLocal: true).catchError((e) {
          print('Error while playing audio = $e');
        });
        print("PLAYING $r");
      } else
        print('Some error #43653');
    } else {
      await audioPlayer.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () async {
              if (widget.sound.isDownloaded)
                playSound();
              else {
                setState(() {
                  isDownloading = true;
                });
                print("DOWNLOAD STARTED");
                await downloadSound(widget.sound);
                await downloadSvg(widget.sound);
                setState(() {
                  isDownloading = false;
                });
                playSound();
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// icons
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      width: 51,
                      height: 51,
                      decoration: isDownloading
                          ? ShapeDecoration(
                              shape: const CircleBorder(
                                  side: BorderSide(color: Colors.orange)),
                            )
                          : BoxDecoration(
                              color: widget.sound.isSelected
                                  ? Colors.white.withOpacity(0.3)
                                  : null,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border: !widget.sound.isSelected
                                  ? Border.all(
                                      color: isDownloading
                                          ? Colors.orange
                                          : Colors.white.withOpacity(
                                              Provider.of<NightMode>(context)
                                                      .isNight
                                                  ? 0.6
                                                  : 0.8),
                                    )
                                  : null,
                            ),
                      child: widget.sound.isDownloaded
                          ? SvgPicture.file(
                              File(Data.stringBox.get(widget.sound.image)!),
                              color: Theme.of(context)
                                  .iconTheme
                                  .color!
                                  .withOpacity(
                                      Provider.of<NightMode>(context).isNight
                                          ? 0.6
                                          : 0.8),
                              placeholderBuilder: (BuildContext context) =>
                                  Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Shimmer.fromColors(
                                          enabled: true,
                                          baseColor: Colors.grey[600]!,
                                          highlightColor: Colors.grey[400]!,
                                          child: Icon(
                                            Icons.music_note_rounded,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      )),
                            )
                          : widget.isConnectedToNetwork
                              ? SvgPicture.network(
                                  widget.sound.image,
                                  color: Theme.of(context)
                                      .iconTheme
                                      .color!
                                      .withOpacity(
                                          Provider.of<NightMode>(context)
                                                  .isNight
                                              ? 0.6
                                              : 0.8),
                                  placeholderBuilder: (BuildContext context) =>
                                      Container(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Center(
                                            child: Shimmer.fromColors(
                                              enabled: true,
                                              baseColor: Colors.grey[600]!,
                                              highlightColor: Colors.grey[400]!,
                                              child: Icon(
                                                Icons.music_note_rounded,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            ),
                                          )),
                                )
                              : Icon(
                                  Icons.download_outlined,
                                  color: Theme.of(context)
                                      .iconTheme
                                      .color!
                                      .withOpacity(
                                          Provider.of<NightMode>(context)
                                                  .isNight
                                              ? 0.6
                                              : 0.8),
                                ),
                    ),

                    /// downloading indicator
                    if (isDownloading)
                      SizedBox(
                        width: 51,
                        height: 51,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white
                              .withOpacity(
                                  Provider.of<NightMode>(context).isNight
                                      ? 0.6
                                      : 0.8)),
                          value:
                              (imageDownloadProgress + soundDownloadProgress) /
                                  200,
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 4),
                Flexible(
                  child: Text(
                    widget.sound.name,

                    // '$soundDownloadProgress $imageDownloadProgress',
                    style: TextStyle(
                        fontSize: 12,
                        color: widget.sound.isSelected
                            ? Colors.white
                            : Colors.white.withOpacity(
                                Provider.of<NightMode>(context).isNight
                                    ? 0.6
                                    : 0.8),
                        fontFamily: 'PoppinsLight'),
                  ),
                ),
              ],
            ),
          ),
          if (!widget.sound.isDownloaded &&
              widget.isConnectedToNetwork &&
              !isDownloading)
            Align(
              alignment: Alignment.topRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.7, sigmaY: 4.7),
                  child: Container(
                    decoration: BoxDecoration(
                        // color: Colors.grey,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1,
                            color: isDownloading
                                ? Colors.deepOrange
                                : Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.download_outlined,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Future<void> downloadSound(Sound sound) async {
    //Download sound
    final String dir = (await getApplicationDocumentsDirectory()).path;
    // final String fileName = sound.name.trim();
    final String fileName = UniqueKey().hashCode.toString() + '.s';

    final path = '$dir/$fileName';
    final Dio dio = Dio();
    final response = await dio.download(
      sound.sound,
      path,
      onReceiveProgress: (count, total) {
        double percentage = ((count / total) * 100);
        setState(() {
          soundDownloadProgress = percentage;
        });
        print("DOWNLOAD MP3 PERCENTAGE $percentage");
      },
    );

    print('Response after downloading image = $response');

    //Add Path To Hive
    final f = File(path);
    if (await f.exists()) {
      await Data.stringBox.put(sound.sound, path);
      print('image exist and path = ${f.path}');
    } else
      print('Error while downloading #23232');
  }

  Future<void> downloadSvg(Sound sound) async {
    //Download Svg
    final String dir = (await getApplicationDocumentsDirectory()).path;
    // final String fileName = sound.name.trim();
    final String fileName = UniqueKey().hashCode.toString() + '.i';

    final path = '$dir/$fileName';
    final Dio dio = Dio();
    final response = await dio.download(
      sound.image,
      path,
      onReceiveProgress: (count, total) {
        double percentage = ((count / total) * 100);
        setState(() {
          imageDownloadProgress = percentage;
        });
        print("DOWNLOAD SVG PERCENTAGE $percentage");
      },
    );

    print('Response after downloading image = $response');

    //Add Path To Hive
    final f = File(path);
    if (await f.exists()) {
      await Data.stringBox.put(sound.image, path);
      print('image exist and path = ${f.path}');
    } else
      print('Error while downloading #23232');
  }
}
