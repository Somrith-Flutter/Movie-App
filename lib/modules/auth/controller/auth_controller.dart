import 'package:get/get.dart';
import 'package:legend_cinema/modules/auth/repository/auth_repository.dart';

class AuthController extends GetxController{
  AuthController({required this.repository});

  final AuthRepository repository;
}