import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get thin => weight(FontWeight.w100);

  TextStyle get extraLight => weight(FontWeight.w200);

  TextStyle get light => weight(FontWeight.w300);

  TextStyle get regular => weight(FontWeight.w400);

  TextStyle get medium => weight(FontWeight.w500);

  TextStyle get semiBold => weight(FontWeight.w600);

  TextStyle get bold => weight(FontWeight.w700);

  TextStyle get italic => fontStyle(FontStyle.italic);

  TextStyle get normal => fontStyle(FontStyle.normal);

  TextStyle size(double size) => copyWith(fontSize: size);

  TextStyle textColor(Color v) => copyWith(color: v);

  TextStyle weight(FontWeight v) => copyWith(fontWeight: v);

  TextStyle fontStyle(FontStyle v) => copyWith(fontStyle: v);

  TextStyle setDecoration(TextDecoration v) => copyWith(decoration: v);

  TextStyle fontFamilies(String v) => copyWith(fontFamily: v);

  TextStyle letterSpacingExt(double v) => copyWith(letterSpacing: v);

  TextStyle heightLine(double v) => copyWith(height: v / fontSize);

  TextStyle get letterSpacing0p5 => letterSpacingExt(0.5);

  TextStyle get letterSpacing0p1 => letterSpacingExt(0.1);

  TextStyle get letterSpacing0p2 => letterSpacingExt(0.2);

  TextStyle get textWhite => textColor(Colors.white);

  TextStyle get size8 => size(8);

  TextStyle get size10 => size(10);

  TextStyle get size12 => size(12);

  TextStyle get size13 => size(13);

  TextStyle get size14 => size(14);

  TextStyle get size15 => size(15);

  TextStyle get size16 => size(16);

  TextStyle get size17 => size(17);

  TextStyle get size18 => size(18);

  TextStyle get size20 => size(20);

  TextStyle get size21 => size(21);

  TextStyle get size24 => size(24);

  TextStyle get size38 => size(38);
}
