import 'dart:convert';

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

  Future<dynamic> loginController({required String type}) async {
    setStatus(BaseStatusEnum.inprogress);
    try {
      await repository
          .loginRepo(
              type: type,
              email: email.text,
              phone: number.text,
              password: password.text)
          .then((data) async {
            debugPrint(data);
        if (data != null && !data['error']) {
          accessToken.$ = data['access_token'].toString();
          await accessToken.save();
          debugPrint(accessToken.$);
          setStatus(BaseStatusEnum.success);
        } else {
          setStatus(BaseStatusEnum.failure);
        }
      });
    } catch (_) {
      setStatus(BaseStatusEnum.failure);
    }
    update();
    return null;
  }

  void clear() {
    email.clear();
    password.clear();
    confirmPassword.clear();
    update();
  }
}
