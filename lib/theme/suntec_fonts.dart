import 'package:flutter/material.dart';
import 'package:moneylover/theme/suntec_colors.dart';

class SuntecFonts {
  static String myFontFamily = "Montserrat";
  // static String myFontFamily = "Metropolis";

  static TextStyle medium(
          {Color color = SuntecColor.colorBlue001A4B,
          double fontSize = 10,
          double height}) =>
      TextStyle(
          fontFamily: myFontFamily,
          fontWeight: FontWeight.w500,
          color: color,
          fontSize: fontSize,
          height: height);

  static TextStyle regular(
          {Color color = SuntecColor.colorBlue001A4B,
          double fontSize = 10,
          double height,
          FontStyle fontStyle}) =>
      TextStyle(
          fontFamily: myFontFamily,
          fontWeight: FontWeight.w400,
          color: color,
          fontSize: fontSize,
          height: height,
          fontStyle: fontStyle);

  static TextStyle black(
          {Color color = SuntecColor.colorBlue001A4B,
          double fontSize = 10,
          double height}) =>
      TextStyle(
          fontFamily: myFontFamily,
          fontWeight: FontWeight.w900,
          color: color,
          fontSize: fontSize,
          height: height);

  static TextStyle semiBold(
          {Color color = SuntecColor.colorBlue001A4B,
          double fontSize = 10,
          double height}) =>
      TextStyle(
          fontFamily: myFontFamily,
          fontWeight: FontWeight.w600,
          color: color,
          fontSize: fontSize,
          height: height);

  static TextStyle semiBoldUnderLine(
          {Color color, double fontSize = 13, double height}) =>
      TextStyle(
        fontFamily: myFontFamily,
        fontWeight: FontWeight.w600,
        color: color ?? SuntecColor.big1Color,
        fontSize: fontSize,
        height: height,
        decoration: TextDecoration.underline,
      );

  static TextStyle bold(
          {Color color = SuntecColor.colorBlue001A4B,
          double fontSize = 10,
          double height}) =>
      TextStyle(
          fontFamily: myFontFamily,
          fontWeight: FontWeight.w700,
          color: color,
          fontSize: fontSize,
          height: height);

  static TextStyle light(
          {Color color = SuntecColor.colorBlue001A4B,
          double fontSize = 10,
          double height}) =>
      TextStyle(
          fontFamily: myFontFamily,
          fontWeight: FontWeight.w300,
          color: color,
          fontSize: fontSize,
          height: height);
}
