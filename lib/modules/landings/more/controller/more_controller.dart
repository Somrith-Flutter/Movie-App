import 'dart:ui';
import 'package:get/get.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/modules/landings/more/repository/more_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class MoreController extends GetxController {
//   MoreController({required this.repository});

//   final MoreRepository repository;

//   var locale = Rx<Locale>(const Locale('km', 'KH'));

//   @override
//   void onInit() {
//     super.onInit();
//     _loadSavedLocale();
//   }

//   void changeLocale(String languageCode, String countryCode) async {
//     Locale newLocale = Locale(languageCode, countryCode);
//     locale.value = newLocale; // Update locale directly
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('languageCode', languageCode);
//     await prefs.setString('countryCode', countryCode);
//   }

//   void _loadSavedLocale() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? languageCode = prefs.getString('languageCode');
//     String? countryCode = prefs.getString('countryCode');
//     if (languageCode != null && countryCode != null) {
//       locale.value = Locale(languageCode, countryCode);
//     }
//   }
// }

class MoreController extends GetxController {
  MoreController({required this.repository});

  final MoreRepository repository;

  var locale = Rx<Locale>(const Locale('km', 'KH'));

  @override
  void onInit() {
    super.onInit();
    _loadSavedLocale();
  }

  var currentLocale = const Locale(AppConstant.en, AppConstant.us).obs;

  void changeLocal(String languageCode, String countryCode) {
    currentLocale.value = Locale(languageCode, countryCode);
    Get.updateLocale(currentLocale.value);
  }

  void changeLocale(String languageCode, String countryCode) async {
    Locale newLocale = Locale(languageCode, countryCode);
    locale.value = newLocale; // Update locale directly
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
    await prefs.setString('countryCode', countryCode);
  }

  void _loadSavedLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');
    String? countryCode = prefs.getString('countryCode');
    if (languageCode != null && countryCode != null) {
      locale.value = Locale(languageCode, countryCode);
    }
  }
}


