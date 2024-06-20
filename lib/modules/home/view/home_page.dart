import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/modules/home/controller/home_controller.dart';
import 'package:legend_cinema/modules/home/repository/home_repository.dart';
import 'package:legend_cinema/modules/home/view/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(repository: HomeRepository()),
      initState: (_) => Get.find<HomeController>().onInit(),
      builder: (_) => const Scaffold(
        body: HomeView(),
      ),
    );
  }
}