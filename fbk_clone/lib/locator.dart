import 'package:fbk_clone/core/services/dialog_service.dart';
import 'package:fbk_clone/core/services/firestore_service.dart';
import 'package:fbk_clone/core/services/navigation_service.dart';
import 'package:fbk_clone/core/viewmodels/create_account_view_model.dart';
import 'package:get_it/get_it.dart';

import 'core/services/auth_service.dart';
import 'core/viewmodels/login_view_model.dart';
import 'core/viewmodels/startup_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => FirestoreService());
  // locator.registerLazySingleton(() => Api());
  //
  locator.registerFactory(() => CreateAccViewModel());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => StartUpViewModel());
  // locator.registerFactory(() => HomeModel());
  // locator.registerFactory(() => CommentsModel());
}
