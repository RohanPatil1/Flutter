import 'package:flutter/material.dart';

class RectClipper extends CustomClipper<Rect> {

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

  @override
  Rect getClip(Size size) {
    return const Rect.fromLTRB(0, 0, 1080, 1070);
  }
}