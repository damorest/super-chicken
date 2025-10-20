import 'package:flutter/material.dart';
import 'package:media_test/screens/home/home_screen.dart';
import '../screens/game/game_screen.dart';
import '../screens/how_to_play/how_to_play.dart';
import '../screens/loading/loading_page.dart';
import '../screens/menu/main_menu_screen.dart';
import '../screens/settings/settings_screen.dart';

class AppRouter {
  static const loading = '/loading';
  static const menu = '/menu';
  static const home = '/home';
  static const game = '/game';
  static const settings = '/settings';
  static const howToPlay = '/howToPlay';

  static final routes = <String, WidgetBuilder>{
    loading: (_) => const LoadingScreen(),
    home: (_) => const HomePage(),
    menu: (_) => const MainMenuPage(),
    game: (_) => const GamePage(),
    settings: (_) => const SettingsPage(),
    howToPlay: (_) => const HowToPlay(),
  };
}
