import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/modules/auth/repository/auth_repository.dart';
import 'package:legend_cinema/v_globle.dart';

class AuthController extends GetxController implements GetxService {
  AuthController({required this.repository});
  final TextEditingController email = TextEditingController(text: "");
  final TextEditingController password = TextEditingController(text: "");
  final TextEditingController number = TextEditingController(text: "");
  final TextEditingController confirmPassword = TextEditingController(text: "");
  final AuthRepository repository;
  int? code;
  BaseStatusEnum _status = BaseStatusEnum.inprogress;
  BaseStatusEnum get status => _status;

  void setStatus(BaseStatusEnum status) {
    _status = status;
    update();
  }

  Future<bool> loginController({required String? type}) async {
    setStatus(BaseStatusEnum.inprogress);
    try {
      await repository
          .loginRepo(
        type: type ?? "",
        email: email.text,
        phone: number.text,
        password: password.text,
      ).then((data) async {
        if (data != null && data is Map<String, dynamic>) {
          if (data.containsKey('access_token')) {
            accessToken.$ = data['access_token'].toString();
            await accessToken.save();
            setStatus(BaseStatusEnum.success);
            update();
            return true;
          } else {
            debugPrint('Access token not found in response');
            setStatus(BaseStatusEnum.failure);
          }
        } else {
          debugPrint('Login failed or response format is incorrect');
          setStatus(BaseStatusEnum.failure);
        }
      });
    } catch (e) {
      debugPrint('Exception during login: $e');
      setStatus(BaseStatusEnum.failure);
    }

    update();
    return false;
  }

  void clear() {
    email.clear();
    password.clear();
    confirmPassword.clear();
    number.clear();
    update();
  }
}
