import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/modules/auth/model/auth_model.dart';
import 'package:legend_cinema/modules/auth/repository/auth_repository.dart';
import 'package:legend_cinema/shared/v_globle.dart';

class AuthController extends GetxController implements GetxService {
  AuthController({required this.repository});
  final TextEditingController email = TextEditingController(text: "");
  final TextEditingController password = TextEditingController(text: "");
  final TextEditingController number = TextEditingController(text: "");
  final TextEditingController confirmPassword = TextEditingController(text: "");
  final TextEditingController name = TextEditingController(text: "");
  String? gender;
  final TextEditingController dob = TextEditingController(text: "");
  final AuthRepository repository;
  int? code;
  BaseStatusEnum _status = BaseStatusEnum.inprogress;
  BaseStatusEnum get status => _status;
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  String? selectedGender;
  UserModel? uu;
  bool isPhoneTabSelected = true; 
  bool isToggle = true;
  bool isContinous = false;
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
      )
          .then((data) async {
        if (data != null && data is Map<String, dynamic>) {
          if (data.containsKey('access_token')) {
            accessToken.$ = data['access_token'].toString();
            await accessToken.save();
            await fetchUserController();
            setStatus(BaseStatusEnum.success);
            update();
            return true;
          } else {
            setStatus(BaseStatusEnum.failure);
          }
        } else {
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

  Future<String> registerController() async {
    setStatus(BaseStatusEnum.inprogress);

    try {
      await repository
          .registerRepo(
              name: name.text.trim(),
              email: email.text.trim(),
              phone: number.text.trim(),
              gender: gender.toString().trim(),
              dob: dob.text.trim(),
              password: password.text.trim(),
              passwordConfirmation: confirmPassword.text.trim(),
              profile: null)
          .then((user) {
        if (user.isNotEmpty) {
          debugPrint(user);
          setStatus(BaseStatusEnum.success);
        } else {
          debugPrint("========error");
          setStatus(BaseStatusEnum.failure);
        }
      });
    } catch (e) {
      debugPrint("========> $e");
      setStatus(BaseStatusEnum.failure);
    }
    return "";
  }

  Future<String> logoutController() async {
    if(accessToken.$ != ""){
      accessToken.$ = "";
      await accessToken.save();
      return "";
    }else{
      tokenRefreshMe.$ = "";
      await tokenRefreshMe.save();
      return "";
    }
  }

  Future<String> fetchUserController({String? newToken}) async {
    setStatus(BaseStatusEnum.inprogress);
    try{
      await repository.fetchUserProfileRepo(newToken: newToken??"").then((user) {
        if(user != null){
          uu = user;
          setStatus(BaseStatusEnum.success);
        }else{
          setStatus(BaseStatusEnum.failure);
        }
      });
    }catch(e){
      setStatus(BaseStatusEnum.failure);
      debugPrint("=======?? $e");
    }
    return "";
  }

  void refreshMeController() async {
    try{
      final t = await repository.refreshToken();

      if(t.toString().isNotEmpty){
        tokenRefreshMe.$ = t;
        await tokenRefreshMe.save();
        await fetchUserController(newToken: t);
        debugPrint("new token => $t");
      }
    }catch(e){
      debugPrint("catche $e");
    }

    update();
  }

  void clear() {
    email.clear();
    password.clear();
    confirmPassword.clear();
    number.clear();
    name.clear();
    dob.clear();
    confirmPassword.clear();
    password.clear();
    gender = "";
    selectedGender = "";
    update();
  }
}
