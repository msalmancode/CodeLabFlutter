import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(
    {required String title,
    required String datatoShow,
    Duration? duration,
    SnackPosition? snackPosition,
    Color? backgroundColor,
    Color? textColor}) {
  Get.snackbar(title, datatoShow,
      duration: duration ?? Duration(seconds: 2),
      snackPosition: snackPosition ?? SnackPosition.BOTTOM,
      margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      backgroundColor: backgroundColor ?? Colors.red,
      colorText: textColor ?? Colors.white);
}
