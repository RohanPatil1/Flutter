import 'package:flutter/material.dart';

class Palette {
  static const Color scaffold = Color(0xFFF0F2F5);

  static const Color facebookBlue = Color(0xFF1777F2);
  static const Color facebookDarkBlue = Color(0xff5C79FF);

  static const LinearGradient createRoomGradient = LinearGradient(
    colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
  );

  static const Color online = Color(0xFF4BCB1F);
  static const Color darkBrown = Color(0xff574136);
  static const Color LightBrown = Color(0xffcfb79d);

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
  );

  static const LinearGradient homescreen_0 = LinearGradient(colors: [Color(0xFF005C97), Color(0xFF00dbde)]);
  static const LinearGradient homescreen_1 = LinearGradient(colors: [Color(0xFF7b4397), Color(0xFFdc2430)]);
  static const LinearGradient homescreen_2 = LinearGradient(colors: [Color(0xFFfc00ff), Color(0xFF00dbde)]);
  static const LinearGradient homescreen_3 = LinearGradient(colors: [Color(0xffff0044), Color(0xFFCE48B1)]);
  static const LinearGradient homescreen_4= LinearGradient(colors: [Color(0xFF496AE1), Color(0xFFCE48B1)]);
}
