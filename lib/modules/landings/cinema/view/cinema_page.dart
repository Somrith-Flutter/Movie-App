import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/modules/landings/cinema/controller/cinema_controller.dart';
import 'package:legend_cinema/modules/landings/cinema/repository/cinema_repository.dart';
import 'package:legend_cinema/modules/landings/cinema/view/cinema_view.dart';

class CinemaPage extends StatelessWidget {
  const CinemaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CinemaController>(
      init: CinemaController(repository: CinemaRepository()),
      initState: (_) => Get.find<CinemaController>().onInit(),
      builder: (_) => const Scaffold(
        body: CinemaView(),
      ),
    );
  }
}