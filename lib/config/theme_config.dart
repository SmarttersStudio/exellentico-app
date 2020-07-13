import 'package:ecommerceapp/config/colors.dart';
import 'package:flutter/material.dart';

///
/// Created By Guru (guru@smarttersstudio.com) on 12/06/20 11:52 AM
///
mixin MyThemes{
  
  static final appThemeData = {
    ColorThemes.red : {
      ThemeMode.light: ThemeData.light().copyWith(
        primaryColor: MyColors.brightPrimaryColor,
        accentColor: MyColors.brightAccentColor,
        primaryColorLight: MyColors.brightSecondaryColor,
        backgroundColor: MyColors.brightBackgroundColor,
        scaffoldBackgroundColor: MyColors.brightBackgroundColor,
        colorScheme: ColorScheme.dark().copyWith(
          primary: MyColors.brightPrimaryColor,
          secondary: MyColors.brightSecondaryColor,
          background: MyColors.brightBackgroundColor,
        )
      ),
      ThemeMode.dark: ThemeData.dark().copyWith(
        primaryColor: MyColors.darkPrimaryColor,
        accentColor: MyColors.darkAccentColor,
        primaryColorLight: MyColors.darkSecondaryColor,
        backgroundColor: MyColors.darkBackgroundColor,
        scaffoldBackgroundColor: MyColors.darkBackgroundColor,
        colorScheme: ColorScheme.dark().copyWith(
          primary: MyColors.darkPrimaryColor,
          secondary: MyColors.darkSecondaryColor,
          background: MyColors.darkBackgroundColor,
        )
      )
    }
  };
}
enum ColorThemes{
  red
}

