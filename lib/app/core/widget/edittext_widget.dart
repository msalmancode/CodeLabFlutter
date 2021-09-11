import 'package:codelabs/app/core/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget tab({required String label}) {
  return Tab(
    child: Text(label),
  );
}

Widget SingleRow_Edit_Text({
  String? title,
  required TextEditingController controller,
  int? maxLine,
  TextInputType? inputType,
  bool? isEnable,
  int? maxLength,
  ValueChanged<String>? valueChanged,
  GestureTapCallback? gestureTapCallback,
}) {
  print("Enable" + isEnable.toString());
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Container(
      color: KColor.white,
      child: TextField(
        enabled: isEnable ?? true,
        maxLines: maxLine ?? 1,
        keyboardType: inputType ?? TextInputType.text,
        maxLength: maxLength ?? null,
        decoration: InputDecoration(
            hintText: title ?? "Enter $title",
            labelText: title ?? "Enter $title",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(3))),
        onChanged: valueChanged,
        controller: controller,
        onTap: gestureTapCallback,
      ),
    ),
  );
}
