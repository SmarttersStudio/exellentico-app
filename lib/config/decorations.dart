import 'package:flutter/material.dart';
///
/// Created By Guru (guru@smarttersstudio.com) on 12/06/20 11:51 AM
///
mixin MyDecorations{

    static InputDecoration textFieldDecoration(){
        return InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
        );
    }
  
}
