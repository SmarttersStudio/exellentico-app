import 'package:flutter/material.dart';

///
/// Created By Guru (guru@smarttersstudio.com) on 12/06/20 1:18 PM
///
extension ThemeModeExtension on ThemeMode{
  
  int get index => ThemeModeExtension.toInt(this) ;
  
  static ThemeMode fromInt(int index){
    switch(index){
      case 1 :
        return ThemeMode.light ;
      case 2 :
        return ThemeMode.dark ;
      default:
        return ThemeMode.system;
    }
  }
  
  static int toInt(ThemeMode themeMode){
    switch(themeMode){
      case ThemeMode.light :
        return 1 ;
      case ThemeMode.dark :
        return 2 ;
      default :
        return 3 ;
    }
  }
  
}
