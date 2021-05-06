import 'package:chill_sounds/data/dataBox.dart';
import 'package:flutter/foundation.dart';

class NightMode extends ChangeNotifier {
  bool _isNight = Data.boolBox.get(_key, defaultValue: false)!;

  bool get isNight {
    return _isNight;
  }

  set isNight(bool value) {
    Data.boolBox.put(_key, value);
    _isNight = value;

    notifyListeners();
  }
}

const _key = 'isNight';
