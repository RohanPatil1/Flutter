import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';

void main() => runApp(MuseIT());

class MuseIT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, brightness: Brightness.light),
      home: MainScreen(),
    );
  }
}
