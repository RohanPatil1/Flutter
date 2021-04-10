import 'package:flutter/material.dart';
import 'package:muse_itv2/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'CenturyGothicR',
      ),

      home: HomePage(),
    );
  }
}
