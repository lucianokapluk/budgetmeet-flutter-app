import 'package:flutter/material.dart';

class DarkModeProvider with ChangeNotifier {
  bool _darkMode;

  bool get darkMode {
    return this._darkMode;
  }

  set darkMode(bool value) {
    this._darkMode = value;
    notifyListeners();
  }
}
