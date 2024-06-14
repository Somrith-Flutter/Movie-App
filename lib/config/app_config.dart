import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/app_controller.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/core/splash_screen.dart';
import 'package:legend_cinema/shared/share_preference.dart'; 
import 'package:legend_cinema/shared/v_globle.dart';

class LegendCinemaApp extends StatefulWidget {
  const LegendCinemaApp({super.key});

  @override
  State<LegendCinemaApp> createState() => _LegendCinemaAppState();
}

class _LegendCinemaAppState extends State<LegendCinemaApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    loadShareValue();
    _loadLocale();
  }

  void loadShareValue() {
    accessToken.load();
  }

  void _loadLocale() async {
    final savedLocale = await SharedPrefs.loadSelectedLanguage();
    setState(() {
      _locale = Locale(savedLocale.languageCode, savedLocale.countryCode);
      Get.updateLocale(_locale!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.appName,
      theme: AppConstant.themeLight,
      darkTheme: AppConstant.themeDark,
      themeMode: AppConstant.themeMode,
      initialBinding: AppController(),
      supportedLocales: AppConstant.supportLocalLanguage,
      localizationsDelegates: AppConstant.delegate,
      locale: _locale,
      fallbackLocale: AppConstant.fallbacklocal,
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
