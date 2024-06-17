import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/modules/landings/more/model/about_model.dart';
import 'package:legend_cinema/modules/landings/more/model/news_model.dart';
import 'package:legend_cinema/modules/landings/more/repository/more_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreController extends GetxController {
  MoreController({required this.repository});

  final MoreRepository repository;
  var locale = Rx<Locale>(const Locale('km', 'KH'));
  final int developerCode = 2024;
  var isDeveloperModeEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedLocale();
    fetchNewsAndActivities();
    fetchAboutus();
  }

  var currentLocale = const Locale(AppConstant.en, AppConstant.us).obs;

  void changeLocale(String languageCode, String countryCode) async {
    currentLocale.value = Locale(languageCode, countryCode);
    Get.updateLocale(currentLocale.value); // Update app-wide locale

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
    await prefs.setString('countryCode', countryCode);
  }

  void loadSavedLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');
    String? countryCode = prefs.getString('countryCode');
    if (languageCode != null && countryCode != null) {
      currentLocale.value = Locale(languageCode, countryCode);
    }
  }

  var newsAndActivities = <NewsModel>[].obs;

  Future<void> fetchNewsAndActivities() async {
    try {
      isLoading(true);
      var items = await repository.getNewsList();
      newsAndActivities.value = items;
      debugPrint('======== $items');
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
  var aboutus = <AboutModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  Future<void> fetchAboutus() async {
    try {
      isLoading(true);
      var data = await repository.getAbout();
      aboutus.value = data;
      debugPrint('Fetched items: $data');
    } catch (e) {
      errorMessage.value = e.toString();
      debugPrint('Error fetching items: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> enableDeveloperMode() async {
    isDeveloperModeEnabled.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('developerModeEnabled', true);
  }

  Future<void> disableDeveloperMode() async {
    isDeveloperModeEnabled.value = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('developerModeEnabled');
  }
}
