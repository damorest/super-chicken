import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  double _widthFactor = 1.0;

  bool get isDarkMode => _isDarkMode;
  double get widthFactor => _widthFactor;

  void toggleTheme(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void setWidth(double value) {
    _widthFactor = value;
    notifyListeners();
  }
}
