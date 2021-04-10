import 'package:fbk_clone/locator.dart';
import 'package:fbk_clone/ui/shared/palette.dart';
import 'package:fbk_clone/ui/views/startup_view.dart';
import 'package:flutter/material.dart';
import 'package:fbk_clone/ui/router.dart' as Route;
import 'package:google_fonts/google_fonts.dart';

import 'core/managers/dialog_mangaer.dart';
import 'core/services/dialog_service.dart';
import 'core/services/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
/*
TEST CREDENTIALS
test123@test.com
test1234
 */


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'login',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),


      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: Route.Router.generateRoute,
      title: 'Flutter Facebook UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Palette.scaffold,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: StartUpView(),
    );
  }
}
