import 'dart:convert';

import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/data_models/user.dart';
import 'package:ecommerceapp/extensions/theme_mode_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const ACCESS_TOKEN_KEY = 'accessToken';
  static const USER_KEY = 'user';
  static const COLOR_KEY = 'color';
  static const THEME_MODE_KEY = 'theme_mode';

  static late SharedPreferences preferences;

  static void storeAccessToken(String accessToken) {
    preferences.setString(ACCESS_TOKEN_KEY, accessToken);
  }

  static String get accessToken =>
      preferences.getString(ACCESS_TOKEN_KEY) ?? "";

  static void clear() {
    preferences.clear();
  }

  static void storeUser({UserResponse? user, String? response}) {
    try {
      if (user != null) {
        preferences.setString(USER_KEY, userResponseToJson(user));
      } else {
        if (response == null || response.isEmpty) {
          throw 'No value to store. Either a User object or a String response is required to store in preference.';
        } else {
          preferences.setString(USER_KEY, response);
        }
      }
    } catch (_, s) {
      print(_.toString());
      print(s);
    }
  }

  static UserResponse? get user => preferences.getString(USER_KEY) != null
      ? userResponseFromJson(preferences.getString(USER_KEY) ?? "{}")
      : null;
}
