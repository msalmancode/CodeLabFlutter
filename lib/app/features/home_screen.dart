import 'package:codelabs/app/core/widget/Elv_Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'intToRoman/UI/int_to_roman.dart';
import 'newsAPI/UI/news_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({key}) : super(key: key);
  final String title = 'Task';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Elv_Button(
              labelText: "Int To Roman",
              callback: _int_to_roman,
            ),
            Elv_Button(
              labelText: "News API",
              callback: _news_api,
            ),
          ],
        ),
      ),
    );
  }

  void _int_to_roman() async {
    // Get.offAllNamed(Routes.IntToRomanScreen);
    Get.dialog(IntToRomanScreen());
  }

  void _news_api() async {
    // Get.offAllNamed(Routes.NewsApiScreen);
    Get.dialog(NewsApiScreen());
  }
}
