import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/modules/auth/controller/auth_controller.dart';
import 'package:legend_cinema/modules/auth/repository/auth_repository.dart';
import 'package:legend_cinema/modules/auth/view/auth_view.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(repository: AuthRepository()),
      initState: (_) => Get.find<AuthController>().onInit(),
      builder: (_) => Scaffold(
        body: AuthView(),
      ),
    );
  }
}