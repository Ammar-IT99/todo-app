import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'ar';
  ThemeMode appTheme = ThemeMode.light;


  void ChangeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void ChangeTheme(ThemeMode newTheme) {
    if (appTheme ==newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();
  }
  bool isDarkMode(){
    return appTheme==ThemeMode.dark;
  }
}
