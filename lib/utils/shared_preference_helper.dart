import 'dart:convert';

import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/data_models/user.dart';
import 'package:ecommerceapp/extensions/theme_mode_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const ACCESS_TOKEN_KEY = 'accessToken';
  static const USER_KEY = 'user';
  static const LOCATION_KEY = 'location';
  static const COLOR_KEY = 'color';
  static const THEME_MODE_KEY = 'theme_mode';
  

  static SharedPreferences preferences;

  static void storeAccessToken(String accessToken) {
    preferences.setString(ACCESS_TOKEN_KEY, accessToken);
  }
  static String get accessToken => preferences.getString(ACCESS_TOKEN_KEY);
  
  static void clear() {
    preferences.clear();
  }

  static void storeLocation(List<double> coordinates) {
    preferences.setString(LOCATION_KEY,
        json.encode(List<dynamic>.from(coordinates.map((x) => x))));
  }

  static List<double> get location => preferences.containsKey(LOCATION_KEY)
      ? List<double>.from(json.decode(preferences.getString(LOCATION_KEY)))
          .map((x) => x.toDouble())
          .toList()
      : [
          85.8196623,
          20.3162543,
        ];
  static ColorThemes get themeColor => preferences.get(COLOR_KEY) ?? ColorThemes.red;

  static void storeThemeColor(ColorThemes colorThemes) {
    preferences.setInt(COLOR_KEY, colorThemes.index);
  }
  static ThemeMode get themeMode => preferences.get(THEME_MODE_KEY) == null
    ? ThemeMode.system
    :ThemeModeExtension.fromInt(preferences.get(THEME_MODE_KEY));

  static void storeThemeMode(ThemeMode themeMode) {
    preferences.setInt(THEME_MODE_KEY, themeMode.index);
  }

  static void storeUser({UserResponse user, String response}) {
    try{
      if(user!=null){
        preferences.setString(USER_KEY, userResponseToJson(user));
      }else{
        if(response==null || response.isEmpty){
          throw 'No value to store. Either a User object or a String response is required to store in preference.';
        }else{
          preferences.setString(USER_KEY, response);
        }
      }
    }catch(_,s){
      print(_.toString());
      print(s);
    }
  }

  static UserResponse get user =>
      preferences.getString(USER_KEY)!=null ? userResponseFromJson(preferences.getString(USER_KEY)) : null;

}

