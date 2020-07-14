
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 6:02 AM
///


class MySnackbar{
  static void show(String title, String message){
    Get.snackbar(
        title, message, snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        animationDuration: const Duration(
            milliseconds: 300),
        margin: const EdgeInsets.all(16));
  }
}
