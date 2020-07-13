import 'dart:async';
import 'package:ecommerceapp/config/theme_config.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../base_state.dart';
import 'index.dart';

@immutable
abstract class ThemeEvent {
  Stream<BaseState> applyAsync({BaseState currentState, ThemeBloc bloc});
}


class ThemeChanged extends ThemeEvent {
  final ThemeMode theme;
  
  ThemeChanged(this.theme);

  @override
  String toString() {
    return 'themeChanged';
  }

  @override
  Stream<BaseState> applyAsync({BaseState currentState, ThemeBloc bloc}) async* {
    SharedPreferenceHelper.storeThemeMode(theme);
    yield ThemeState(ColorThemes.red,theme);
  }
}
