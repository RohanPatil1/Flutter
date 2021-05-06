import 'package:audioplayers/audioplayers.dart';
import 'package:chill_sounds/data/dataBox.dart';
import 'package:chill_sounds/widgets/lottieButton.dart';
import 'package:chill_sounds/widgets/sldingUpPanel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'modal.dart';

class AudioBrain extends ChangeNotifier {
  static final AudioBrain _singleton = AudioBrain._internal();

  factory AudioBrain() {
    return _singleton;
  }

  AudioBrain._internal();

  static void init() {
    final lastSelectedSounds =
        Data.soundBox.values.where((element) => element.isSelected).toList();
    if (lastSelectedSounds.isNotEmpty) sounds.addAll(lastSelectedSounds);
  }

  static List<Sound> sounds = [];
  bool isAnyAudioPlaying = false;

  final PanelController _slideUpCtrl = PanelController();

  static GlobalKey<LottieButtonState> key = GlobalKey<LottieButtonState>();

  PanelController get slideUpCtrl => _slideUpCtrl;

  int addRemoveSound(Sound sound) {
    checkAllAudio();

    if (sounds
        .where((element) => sound.soundId == element.soundId)
        .toList()
        .isEmpty) {
      if (!isAnyAudioPlaying &&
          key.currentState != null &&
          key.currentState!.mounted) {
        sounds.forEach((element) {
          element.audioPlayer.resume();
        });
        key.currentState!.onPlay();
      }

      isAnyAudioPlaying = true;
      sounds.add(sound);
      sound.isSelected = true;
      if (_slideUpCtrl.isPanelClosed) {
        _slideUpCtrl.open();
      }
      notifyListeners();
      print("Sound Added: ${sound.name}");
      return 1;
    } else {
      isAnyAudioPlaying = false;
      sound.audioPlayer.stop();
      sound.isSelected = false;
      sounds.remove(sound);

      if (sounds.isEmpty && _slideUpCtrl.isPanelOpen) {
        _slideUpCtrl.close();
      }

      notifyListeners();
      print("Sound Removed: ${sound.name}");
      return 0;
    }
  }

//Volume will be 0.0 to 1.0
  void changeVolume(Sound sound, double volume) {
    sound.audioPlayer.setVolume(volume);
    notifyListeners();
    print("Sound Volume Changed: ${sound.name} $volume");
  }

//SlideUp Panel Control Utils
  void onTapMenu(BuildContext context) {
    if (_slideUpCtrl.isPanelClosed) {
      _slideUpCtrl.open();
    } else {
      _slideUpCtrl.close();
    }
    notifyListeners();
  }

//Play/Pause All the audios from the panel
  void pauseAllAudio() {
    // isAudioPlaying = !isAudioPlaying;

    checkAllAudio();

    if (isAnyAudioPlaying) {
      sounds.forEach((element) {
        element.audioPlayer.pause();
      });
    } else {
      sounds.forEach((element) {
        element.audioPlayer.resume();
      });
    }
    isAnyAudioPlaying = !isAnyAudioPlaying;

    notifyListeners();
  }

  void pauseAudio(Sound sound) {
    if (sound.audioPlayer.state == AudioPlayerState.PLAYING) {
      sound.audioPlayer.pause();
      sound.audioPlayer.state = AudioPlayerState.PAUSED;
    } else {
      sound.audioPlayer.resume();
      sound.audioPlayer.state = AudioPlayerState.PLAYING;
    }
    checkAllAudio();
    notifyListeners();
  }

  void checkAllAudio() {
    isAnyAudioPlaying = false;
    sounds.forEach((element) {
      if (element.audioPlayer.state == AudioPlayerState.PLAYING) {
        print("Sound is playing ${element.name}  ");
        isAnyAudioPlaying = true;
      } else {
        print(
            "Sound NOT playing ${element.name}  ${element.audioPlayer.state}");
      }
    });
    print("checkAllAudio() isAnyAudioPlaying = $isAnyAudioPlaying");
    notifyListeners();
  }
}
