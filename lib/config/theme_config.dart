import 'package:ecommerceapp/config/colors.dart';
import 'package:flutter/material.dart';

///
/// Created By Guru (guru@smarttersstudio.com) on 12/06/20 11:52 AM
///
mixin MyThemes {
  static final appThemeData = {
    ColorThemes.red: {
      ThemeMode.light: ThemeData(
          fontFamily: 'Mulish',
          primarySwatch: MyColors.brightPrimary,
          primaryColor: MyColors.brightPrimary,
          accentColor: MyColors.brightPrimary,
          canvasColor: MyColors.brightBackgroundColor,
          cursorColor: MyColors.brightPrimary,
          iconTheme: IconThemeData(color: Colors.black),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
          textSelectionHandleColor: MyColors.brightPrimary,
          textSelectionColor: MyColors.brightPrimary.withOpacity(0.3)),
      ThemeMode.dark: ThemeData(
          fontFamily: 'Mulish',
          primarySwatch: MyColors.darkPrimary,
          primaryColor: MyColors.darkPrimary,
          accentColor: MyColors.darkPrimary,
          canvasColor: MyColors.darkBackgroundColor,
          cursorColor: MyColors.darkPrimary,
          iconTheme: IconThemeData(color: Colors.white),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
          textSelectionHandleColor: MyColors.darkPrimary,
          textSelectionColor: MyColors.darkPrimary.withOpacity(0.3))
    }
  };
}
enum ColorThemes { red }
