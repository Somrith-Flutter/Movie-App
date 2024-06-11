import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/modules/news_and_activity/controller/news_and_activity_controller.dart';
import 'package:legend_cinema/modules/news_and_activity/repository/news_and_activity_repository.dart';
import 'package:legend_cinema/modules/news_and_activity/view/news_and_activity_view.dart';

class NewsAndActivityPage extends StatelessWidget {
  const NewsAndActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsAndActivityController>(
      init: NewsAndActivityController(repository: NewsAndActivityRepository()),
      initState: (_) => Get.find<NewsAndActivityController>().onInit(),
      builder: (_) => const Scaffold(
        body: NewsAndActivityView(),
      ),
    );
  }
}