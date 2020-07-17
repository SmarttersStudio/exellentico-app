import 'dart:ui';

import 'package:flutter/material.dart';

///
/// Created By Guru (guru@smarttersstudio.com) on 12/06/20 11:48 AM
///

mixin MyColors {
  static final Color brightBackgroundColor = Color(0xffFEFEFE);
  static final Color darkBackgroundColor = Color(0xff4d4d4d);

  static const MaterialColor darkPrimary =
      MaterialColor(0xFFF42A83, <int, Color>{
    50: Color(0xFFFEE5F0),
    100: Color(0xFFFCBFDA),
    200: Color(0xFFFA95C1),
    300: Color(0xFFF76AA8),
    400: Color(0xFFF64A96),
    500: Color(0xFFF42A83),
    600: Color(0xFFF3257B),
    700: Color(0xFFF11F70),
    800: Color(0xFFEF1966),
    900: Color(0xFFEC0F53),
  });

  static const MaterialColor brightPrimary =
      MaterialColor(0xFF6078EA, <int, Color>{
    50: Color(0xFFECEFFC),
    100: Color(0xFFCFD7F9),
    200: Color(0xFFB0BCF5),
    300: Color(0xFF90A1F0),
    400: Color(0xFF788CED),
    500: Color(0xFF6078EA),
    600: Color(0xFF5870E7),
    700: Color(0xFF4E65E4),
    800: Color(0xFF445BE1),
    900: Color(0xFF3348DB),
  });
}

LinearGradient getDynamicGradient(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  if (colorScheme.brightness == Brightness.light) {
    return LinearGradient(
      colors: const [
        Color(0xff17EAD9),
        Color(0xFF6078EA),
      ],
    );
  } else {
    return LinearGradient(
      colors: const [
        const Color(0xffF42A83),
        const Color(0xff8E3FFC),
      ],
    );
  }
}
