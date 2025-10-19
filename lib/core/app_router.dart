import 'package:flutter/material.dart';
import 'package:media_test/screens/home/home_screen.dart';
import '../screens/loading/loading_page.dart';
import '../screens/menu/main_menu_screen.dart';

class AppRouter {
  static const loading = '/loading';
  static const menu = '/menu';
  static const home = '/home';

  static final routes = <String, WidgetBuilder>{
    loading: (_) => const LoadingScreen(),
    home: (_) => const HomePage(),
    menu: (_) => const MainMenuPage(),
  };
}
