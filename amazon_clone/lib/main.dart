import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import 'ui_components/category_list.dart';
import 'ui_components/product_list.dart';
import 'screens/product_details.dart';
import 'screens/cart.dart';
import 'screens/login.dart';
import 'screens/splash.dart';
import 'new.dart';
import 'screens/home.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    builder: (_) => UserProvider.initalise(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreensController(),
    ),
  ));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    switch (user.status) {
      case Status.Uninitialised:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return Home();

      default:
        return Login();
    }

    return Container();
  }
}

//backgroundColor: Color.fromARGB(255, 102, 18, 222),
