import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  ThemeData getTheme() => _themeData;

  void toggleTheme() {
    if (_themeData.brightness == Brightness.dark) {
      _themeData = _getLightTheme();
    } else {
      _themeData = _getDarkTheme();
    }

    notifyListeners();
  }

  static ThemeData _getLightTheme() {
    return ThemeData(
        brightness: Brightness.light,
        textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Open Sans'));
  }

  static ThemeData _getDarkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Open Sans'));
  }

  factory ThemeChanger.defaultTheme() => ThemeChanger(_getDarkTheme());
}
