import 'package:fbk_clone/ui/views/create_account_screen.dart';
import 'package:fbk_clone/ui/views/landing_page.dart';
import 'package:fbk_clone/ui/views/login_page.dart';
import 'package:fbk_clone/ui/views/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'views/home_screen.dart';

const String initialRoute = "login";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LandingPage());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case 'nav_screen':
        return MaterialPageRoute(builder: (_) => NavScreen());
      case 'create_account':
        return MaterialPageRoute(builder: (_) => CreateAccountScreen());
      // case 'post':
      //   var post = settings.arguments as Post;
      //   return MaterialPageRoute(builder: (_) => PostView(post: post));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
