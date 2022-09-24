import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:moneylover/common/common.dart';
import 'package:moneylover/theme/suntec_colors.dart';
import 'package:moneylover/theme/suntec_fonts.dart';

class SuntecThemeData {
  static const double _textfieldCornerRadius = 12;
  static final InputBorder _textfieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(_textfieldCornerRadius),
    borderSide: BorderSide.none,
  );

  static final themeData = ThemeData(
    fontFamily: SuntecFonts.myFontFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: SuntecColor.colorBlue001A4B,
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
      centerTitle: true,
      toolbarTextStyle: _textTheme
          .copyWith(
            headline6: SuntecFonts.bold().size20.textWhite,
          )
          .bodyText2,
      titleTextStyle: _textTheme
          .copyWith(
            headline6: SuntecFonts.bold().size20.textWhite,
          )
          .headline6,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: _colorScheme.primary,
    ),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      colorScheme: _colorScheme,
    ),
    bottomAppBarColor: Colors.white,
    canvasColor: _colorScheme.background,
    toggleableActiveColor: _colorScheme.primary,
    highlightColor: Colors.transparent,
    indicatorColor: _colorScheme.onPrimary,
    primaryColor: _colorScheme.primary,
    backgroundColor: _colorScheme.background,
    scaffoldBackgroundColor: _colorScheme.background,
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
    typography: Typography.material2018(
      platform: defaultTargetPlatform,
    ),
    textTheme: _textTheme,
    // input
    inputDecorationTheme: InputDecorationTheme(
        errorMaxLines: 2,
        helperMaxLines: 2,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        isDense: true,
        hintStyle: const TextStyle(color: Color(0xFFBFBFBF)),
        border: _textfieldBorder,
        enabledBorder: _textfieldBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_textfieldCornerRadius),
          borderSide: BorderSide(color: _colorScheme.primary, width: 1.2),
        ),
        errorBorder: _textfieldBorder,
        disabledBorder: _textfieldBorder,
        focusedErrorBorder: _textfieldBorder,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
    colorScheme: _colorScheme.copyWith(secondary: _colorScheme.primary),
  );

  static const _colorScheme = ColorScheme(
    primary: SuntecColor.colorBlue001A4B,
    secondary: Color(0xFFffca4e),
    background: Color(0xffFAFAFA),
    surface: Color(0xFFF2F2F2),
    onBackground: Colors.black,
    onSurface: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    brightness: Brightness.light,
  );

  static const _regular = FontWeight.w400;
  // static const _medium = FontWeight.w500;
  // static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static const TextTheme _textTheme = TextTheme(
    headline1: TextStyle(
      fontWeight: _bold,
      fontSize: 34,
      height: 41 / 34,
    ),
    headline2: TextStyle(
      fontWeight: _bold,
      fontSize: 28,
      height: 34 / 28,
    ),
    headline3: TextStyle(
      fontWeight: _bold,
      fontSize: 22,
      height: 28 / 22,
    ),
    headline4: TextStyle(
      fontWeight: _bold,
      fontSize: 20,
      height: 25 / 20,
    ),
    headline5: TextStyle(
      fontWeight: _bold,
      fontSize: 17,
      height: 22 / 17,
    ),
    headline6: TextStyle(
      fontWeight: _bold,
      fontSize: 15,
      height: 20 / 15,
    ),
    bodyText2: TextStyle(
      fontWeight: _regular,
      fontSize: 15,
      height: 20 / 15,
      // letterSpacing: 1.1,
    ),
  );
}
