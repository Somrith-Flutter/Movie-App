import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/modules/landings/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/modules/landings/f_b/repository/f_b_repository.dart';
import 'package:legend_cinema/modules/landings/f_b/view/f_b_view.dart';

class FBPage extends StatelessWidget {
  const FBPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FBController>(
      init: FBController(repository: FBRepository()),
      initState: (_) => Get.find<FBController>().onInit(),
      builder: (_) => const Scaffold(
        body: FBView(),
      ),
    );
  }
}