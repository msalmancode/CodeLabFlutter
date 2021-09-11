import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app/features/home_screen.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Code Labs Flutter Task',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(),
      getPages: AppPages.routes,
    );
  }
}
