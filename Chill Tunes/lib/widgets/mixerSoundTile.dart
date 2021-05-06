import 'dart:io';

import 'package:chill_sounds/data/audioBrain.dart';
import 'package:chill_sounds/data/dataBox.dart';
import 'package:chill_sounds/data/modal.dart';
import 'package:chill_sounds/data/nightMode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';



class MixerSoundTile extends StatefulWidget {
  final Sound sound;

  const MixerSoundTile({Key? key, required this.sound}) : super(key: key);

  @override
  _MixerSoundTileState createState() => _MixerSoundTileState();
}

class _MixerSoundTileState extends State<MixerSoundTile> {
  double value = 0.5;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          AudioBrain().pauseAudio(widget.sound);
        },
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
              )),
          padding: EdgeInsets.all(6),
          child: Center(
            child: SvgPicture.file(
              File(Data.stringBox.get(widget.sound.image)!),
              color: Theme.of(context).iconTheme.color!.withOpacity(
                  Provider.of<NightMode>(context).isNight ? 0.6 : 0.8),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      title: Text(
        widget.sound.name,
        style: TextStyle(
            fontSize: 12,
            color: const Color(0xfff2f2f2),
            fontFamily: 'PoppinsMedium'),
      ),
      subtitle: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: const Color(0xff9079A6),
          inactiveTrackColor: Colors.white.withOpacity(0.3),
          thumbColor: Colors.white.withOpacity(0.8),
          overlayColor: Color(0x29eb1555),
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 15.0),
          trackHeight: 1,
        ),
        child: Slider(
          min: 0.0,
          max: 1.0,
          onChanged: (double v) {
            setState(() {
              value = v;
            });

            Provider.of<AudioBrain>(context, listen: false)
                .changeVolume(widget.sound, value);
          },
          value: value,
          // activeColor: const Color(0xff9079A6),
          // inactiveColor: const Color(0x60FDFDFD),
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          //When AudioBrain becomes empty,Close the panel
          if (AudioBrain.sounds.length == 1) {
            Provider.of<AudioBrain>(context, listen: false).onTapMenu(context);
          }

          //Remove Sound
          Provider.of<AudioBrain>(context, listen: false)
              .addRemoveSound(widget.sound);
        },
        child: Icon(
          Icons.clear,
          color: Colors.white.withOpacity(0.6),
        ),
      ),
    );
  }
}
