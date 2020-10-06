import 'package:fbk_clone/core/services/auth_service.dart';
import 'package:fbk_clone/core/services/dialog_service.dart';
import 'package:fbk_clone/core/services/navigation_service.dart';
import 'package:fbk_clone/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future logInUser({@required String email, @required String password}) async {
    setBusy(true);
    var result = await _authService.logInUser(email: email, password: password);
    setBusy(false);
    if (result is bool) {
      if (result) {
        _navigationService.navigateTo("home");
      } else {
        await _dialogService.showDialog(
            title: "Failed!", description: "Try Again!");
      }
    } else {
      await _dialogService.showDialog(title: "Failed!", description: result);
    }
  }
}
