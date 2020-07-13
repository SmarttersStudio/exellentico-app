import 'package:ecommerceapp/config/theme_config.dart';
import 'package:flutter/material.dart';

import '../base_state.dart';

/// Initialized
class ThemeState extends BaseState {
  final ColorThemes color;
  final ThemeMode mode ;

  ThemeState(this.color,this.mode);

  @override
  String toString() => 'Theme State';

  @override
  BaseState getStateCopy() {
    return ThemeState(color,mode);
  }
}

