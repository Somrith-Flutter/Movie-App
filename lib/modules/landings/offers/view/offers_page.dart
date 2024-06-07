import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/landings/offers/controller/offers_controller.dart';
import 'package:legend_cinema/modules/landings/offers/repository/offers_repository.dart';
import 'package:legend_cinema/modules/landings/offers/view/offers_view.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OffersController>(
      init: OffersController(repository: OffersRepository()),
      initState: (_) => Get.find<MoreController>().onInit(),
      builder: (_) => const Scaffold(
        body: OffersView(),
      ),
    );
  }
}