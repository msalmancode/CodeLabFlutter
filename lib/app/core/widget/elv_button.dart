import 'package:flutter/material.dart';

class Elv_Button extends StatelessWidget {
  final String labelText;
  final VoidCallback callback;

  Elv_Button({Key? key, required this.labelText, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                onPressed: callback,
                child: Text(
                  labelText,
                  style: TextStyle(),
                ))));
  }
}
