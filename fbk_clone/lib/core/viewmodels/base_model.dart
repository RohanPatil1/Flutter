import 'package:fbk_clone/core/enums/viewstate.dart';
import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setBusy(bool isBusy) {
    if (isBusy) {
      _state = ViewState.Busy;
    } else {
      _state = ViewState.Idle;
    }
    notifyListeners();
  }
}
