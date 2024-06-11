import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/modules/news_and_activity/model/news_and_activity_model.dart';
import 'package:legend_cinema/modules/news_and_activity/repository/news_and_activity_repository.dart';

class NewsAndActivityController extends GetxController{
  NewsAndActivityController({required this.repository});

  final NewsAndActivityRepository repository;
  var newsAndActivities = <NewsAndActivityModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNewsAndActivities();
  }

  Future<void> fetchNewsAndActivities() async {
    try {
      isLoading(true);
      var items = await repository.getNewsList();
      newsAndActivities.value = items;
      debugPrint('$items');
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}