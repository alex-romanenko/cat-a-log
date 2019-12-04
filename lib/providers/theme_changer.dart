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

  ThemeData _getLightTheme() {
    return ThemeData(
        brightness: Brightness.light,
        textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Open Sans'));
  }

  ThemeData _getDarkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Open Sans'));
  }

  /// Initializes ThemeChanger with a default dark theme.
  factory ThemeChanger.defaultTheme() => ThemeChanger(ThemeData(
      brightness: Brightness.dark,
      textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Open Sans')));
}
