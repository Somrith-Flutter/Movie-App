import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/app_controller.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/modules/landings/home/view/home_page.dart';

class LegendCinemaApp extends StatelessWidget {
  const LegendCinemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.appName,
      theme: AppConstant.dark,
      darkTheme: AppConstant.dark,
      themeMode: ThemeMode.dark,
      initialBinding: AppController(),
      supportedLocales: AppConstant.localLanguages,
      localizationsDelegates: AppConstant.delegate,
      home: const HomePage(),
    );
  }
}
