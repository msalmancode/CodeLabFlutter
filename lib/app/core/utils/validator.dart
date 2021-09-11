import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';

import 'constants.dart';

class Validator {
  static bool validator(List<NestedValidator> _field) {
    if (_field.isNotEmpty) {
      for (int i = 0; i < _field.length; i++) {
        print("fa:" + _field[i].toString());
        if (_field[i]._isValidate == false) {
          Get.snackbar("Requried*", _field[i]._errorMessage,
              duration: Duration(seconds: 2),
              snackPosition: SnackPosition.BOTTOM,
              margin: EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
              backgroundColor: KColor.kPrimaryColor,
              colorText: KColor.white);
          return false;
        }
        if (i == _field.length - 1) {
          if (_field[i]._isValidate == true) {
            return true;
          }
        }
      }
    }
    return false;
  }

  static bool validateEditText(String? _value) {
    if (_value != null) {
      if (_value.trim().isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}

class NestedValidator {
  bool _isValidate = false;
  String _errorMessage = "";

  NestedValidator({required bool isValidate, required String errorMessage}) {
    this._isValidate = isValidate;
    this._errorMessage = errorMessage;
  }
}
