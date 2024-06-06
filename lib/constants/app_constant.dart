import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';

class AppConstant{
  static const String appName = 'Legend Cinema';
  static const String version = ' 1.0.0';

  // Date format
  static const String defaultDateFormat = 'dd/MM/yyyy';
  static const String normalDateFormat = 'dd/MM/yyyy';
  static const String monthDateFormat = 'MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy hh:mm a';
  static const String timeFormat = 'hh:mm a';
  static const String dobFormat = 'dd/MM/yyyy';
  static const String registeredFormat = 'dd/MM/yyyy hh:mm a';
  static const String publishedDateFormat = 'dd/MM/yyyy hh:mm a';
  static DateTime minDate = DateTime.parse("1900-01-01");
  static DateTime maxDate = DateTime.parse("2500-12-31");

  // Defualt Theme
  static ThemeData dark = ThemeData.dark();

  // Number format
  static const String decimalFormat = '#,##0.00;-#,##0.00;0.00';
  static const String noneDecimalFormat = '#,##0;-#,##0;0';

  // Defualt local languages.
  static const List<Locale> localLanguages = [
    Locale('en', 'US'),  Locale('km', 'KH'),
  ];

  // English language
  static const String en = 'en';
  static const String us = 'US';

  // khmer language 
  static const String km = 'km';
  static const String kh = 'KH';
  
  static const List<LocalizationsDelegate<dynamic>> delegate = [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

}