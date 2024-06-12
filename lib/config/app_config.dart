import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/app_controller.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/core/splash_screen.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/v_globle.dart';

class LegendCinemaApp extends StatefulWidget {
  const LegendCinemaApp({super.key});

  @override
  State<LegendCinemaApp> createState() => _LegendCinemaAppState();
}

class _LegendCinemaAppState extends State<LegendCinemaApp> {
  @override
  void initState() {
    loadShareValue();
    super.initState();
  }

  void loadShareValue() {
    accessToken.load();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.appName,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      initialBinding: AppController(),
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: AppConstant.delegate,
      fallbackLocale: const Locale('km', 'KH'),
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}

// class LegendCinemaApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Locale>(
//       future: SharedPrefs.loadLocale(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else {
//           if (snapshot.hasData) {
//             Get.updateLocale(snapshot.data!); // Update locale immediately without restarting app
//             return GetMaterialApp(
//               debugShowCheckedModeBanner: false,
//               title: AppConstant.appName,
//               theme: AppConstant.dark,
//               darkTheme: AppConstant.dark,
//               themeMode: ThemeMode.dark,
//               initialBinding: AppController(),
//               supportedLocales: S.delegate.supportedLocales,
//               localizationsDelegates: AppConstant.delegate,
//               locale: snapshot.data,
//               fallbackLocale: const Locale('km', 'KH'),
//               home: SplashScreen(),
//             );
//           } else {
//             // Handle error if unable to load locale
//             return const Center(
//               child: Text('Error loading locale'),
//             );
//           }
//         }
//       },
//     );
//   }
// }
