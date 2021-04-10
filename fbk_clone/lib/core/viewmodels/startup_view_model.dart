import 'package:fbk_clone/core/services/auth_service.dart';
import 'package:fbk_clone/core/services/dialog_service.dart';
import 'package:fbk_clone/core/services/navigation_service.dart';
import 'package:fbk_clone/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class StartUpViewModel extends BaseModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogin() async {
  print("HANDLING STARTUP LOGIC");
    var isLoggedIn = await _authService.isUserLoggedIn();
    // if (isLoggedIn) {
    //   print("HANDLING STARTUP LOGIC => Found 1");
    //
    //   _navigationService.navigateTo("home");
    // } else {
    //   print("HANDLING STARTUP LOGIC=> Found 2");
    //
    //   _navigationService.navigateTo("login");
    // }
  }
}
