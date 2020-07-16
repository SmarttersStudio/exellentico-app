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

    static InputDecoration authTextFieldDecoration(){
        return InputDecoration(
            hintStyle: TextStyle(fontSize: 15, color: Color(0xff9b9b9b)) ,
            fillColor: Color(0xfff0f0f0),
            filled: true,
            errorStyle: TextStyle(fontSize: 11, height: 1, color: Colors.red),
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(width: 0.5)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide(color:  Color(0xfff0f0f0))),
        );
    }


}
