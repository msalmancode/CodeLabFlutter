import 'package:codelabs/app/features/home_screen.dart';
import 'package:codelabs/app/features/intToRoman/UI/int_to_roman.dart';
import 'package:codelabs/app/features/newsAPI/UI/news_api.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.Home_Screen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.IntToRomanScreen,
      page: () => IntToRomanScreen(),
    ),
    GetPage(
      name: Routes.NewsApiScreen,
      page: () => NewsApiScreen(),
    ),
  ];
}
