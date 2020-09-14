import 'package:flutter/material.dart';
import 'package:quizzinga/screens/main_screen.dart';

void main() => runApp(Quizzinga());

class Quizzinga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
