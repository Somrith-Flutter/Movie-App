import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/modules/auth/repository/auth_repository.dart';
import 'package:legend_cinema/v_globle.dart';

class AuthController extends GetxController implements GetxService{
  AuthController({required this.repository});
  final TextEditingController email = TextEditingController(text: "");
  final TextEditingController password = TextEditingController(text: "");
  final TextEditingController number = TextEditingController(text: "");
  final TextEditingController confirmPassword = TextEditingController(text: "");
  final AuthRepository repository;
  BaseStatusEnum _status = BaseStatusEnum.inprogress;
  BaseStatusEnum get status => _status;

  void setStatus(BaseStatusEnum status) {
    _status = status;
    update();
  }

  Future<String> loginController({required String type}) async {
    setStatus(BaseStatusEnum.inprogress);
    try{
      final data = repository.loginRepo(
      type: type, 
      email: email.text, 
      password: password.text);

      if(data.toString().isNotEmpty){
          accessToken.$ = data.toString();
          await accessToken.save();
          setStatus(BaseStatusEnum.success);
      }else{
        setStatus(BaseStatusEnum.failure);
      }
    }catch(_){}
    update();
    return "";  
  }

  void clear(){
    email.clear();
    password.clear();
    confirmPassword.clear();
    update();
  }
}