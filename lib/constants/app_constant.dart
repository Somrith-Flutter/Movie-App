import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
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
  static  ThemeMode themeMode = ThemeMode.dark;
  static ThemeData themeLight = ThemeData(brightness: Brightness.light);
  static ThemeData themeDark = ThemeData(brightness: Brightness.dark);

  // Number format
  static const String decimalFormat = '#,##0.00;-#,##0.00;0.00';
  static const String noneDecimalFormat = '#,##0;-#,##0;0';

  // Defualt local languages.
  static const List<Locale> localLanguages = [
    Locale('en', 'US'),  
    Locale('km', 'KH'), 
    Locale('zh', 'CN'),
  ];

  static const fallbacklocal = Locale('km', 'KH');

  // English language
  static const String en = 'en';
  static const String us = 'US';

  // khmer language 
  static const String km = 'km';
  static const String kh = 'KH';

  //Chinese language
  static const String zh = 'zh';
  static const String cn = 'CN'; // Simplified Chinese (China)
  // static const String tw = 'TW'; // Traditional Chinese (Taiwan)
  // static const String hk = 'HK'; // Traditional Chinese (Hong Kong)
  
  static const List<LocalizationsDelegate<dynamic>> delegate = [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  static Iterable<Locale>  supportLocalLanguage = S.delegate.supportedLocales;

  static const String defaultFont = 'Siemreap';
  static const String inlineSeparator = '•';

  static Widget appbarTheme = Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: AppColor.appbarColor,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
      )
    ),
  );

  static const int developerCode = 2024;

  // change it base on your ip address by replace http://127.0.0.1:8000 to your ip.
  static const String baseIosIP = 'http://127.0.0.1:8000';
  // [baseIosUrl] run whole machine.
  static const String baseAndroidIP = 'http://192.168.0.105:8080'; 
  // [baseAndroidUrl] run based on ip Emulator.

  // ios = baseIosIP;      android = baseAndroidIP;
  static const String domainKey = baseAndroidIP;
  // [domainKey] local ip, Switch this one to accept data income from db.
}