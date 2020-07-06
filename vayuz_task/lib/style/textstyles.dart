import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontStyles {
  static TextStyle footerStyle = GoogleFonts.raleway(
      fontWeight: FontWeight.w500, fontSize: 12.0, color: Colors.white);

  static TextStyle headingStyle = GoogleFonts.raleway(
      fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.white);

  static TextStyle nameStyle = GoogleFonts.lato(
      fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white);

  static TextStyle messageStyle = GoogleFonts.lato(
      fontStyle: FontStyle.italic, fontSize: 16.0, color: Colors.white);

  static TextStyle dateTimeStyle =
      GoogleFonts.lato(fontSize: 13.0, color: Colors.white);

  static TextStyle statusStyle = GoogleFonts.raleway(
      fontWeight: FontWeight.bold, fontSize: 12.0, color: Color(0xff497300));

  static TextStyle detailsMsgStyle = GoogleFonts.lato(
      fontStyle: FontStyle.normal, fontSize: 14.0, color: Colors.white);

  static TextStyle detailsUser1Style = GoogleFonts.raleway(
      fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.white);

  static TextStyle detailsUser2Style = GoogleFonts.raleway(
      fontWeight: FontWeight.w900, fontSize: 16.0, color: Colors.white);
}
