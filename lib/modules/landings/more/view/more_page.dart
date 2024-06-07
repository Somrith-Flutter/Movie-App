import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/landings/more/repository/more_repository.dart';
import 'package:legend_cinema/modules/landings/more/view/more_view.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoreController>(
      init: MoreController(repository: MoreRepository()),
      initState: (_) => Get.find<MoreController>().onInit(),
      builder: (_) => Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: const MoreView(),
      ),
    );
  }
}