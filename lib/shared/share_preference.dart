import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String languageCodeKey = 'languageCode';
  static const String countryCodeKey = 'countryCode';
  static const String themeModeKey = 'themeMode';

  static Future<void> saveLanguage(String languageCode, String countryCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageCodeKey, languageCode);
    await prefs.setString(countryCodeKey, countryCode);
  }

  static Future<Locale> loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString(languageCodeKey);
    String? countryCode = prefs.getString(countryCodeKey);

    if (languageCode != null && countryCode != null) {
      return Locale(languageCode, countryCode);
    } else {
      return const Locale('km', 'KH');
    }
  }

  static Future<ThemeMode> loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeIndex = prefs.getInt(themeModeKey);
    if (themeIndex != null) {
      return ThemeMode.values[themeIndex];
    } else {
      return ThemeMode.system;
    }
  }

  static Future<void> saveThemeMode(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(themeModeKey, themeMode.index);
  }

  static Future<Locale> loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString(languageCodeKey);
    String? countryCode = prefs.getString(countryCodeKey);

    if (languageCode != null && countryCode != null) {
      return Locale(languageCode, countryCode);
    } else {
      return const Locale('en', 'US');
    }
  }
}
