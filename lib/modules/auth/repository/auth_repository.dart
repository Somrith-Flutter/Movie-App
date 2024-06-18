import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/modules/auth/model/auth_model.dart';
import 'package:legend_cinema/shared/v_globle.dart';

class AuthRepository {
  Future<dynamic> loginRepo(
      {required String type,
      required String? email,
      required String? phone,
      required String password}) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${AppConstant.domainKey}/api/auth/login/$type'));

    request.fields.addAll({
      type != "email" ? "phone" : "email":
          type != 'email' ? phone!.trim() : email!.trim(),
      'password': password.trim()
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      try {
        var json = jsonDecode(body);
        if (json is Map<String, dynamic>) {
          return json;
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<String> registerRepo(
      {required String name,
      required String email,
      required String phone,
      required String gender,
      required String dob,
      required String password,
      required String passwordConfirmation,
      File? profile}) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${AppConstant.domainKey}/api/auth/register'));
    request.fields.addAll({
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
      'date_of_birth': dob,
      'password': password,
      'password_confirmation': passwordConfirmation
    });

    if (profile != null) {
      request.files.add(
          await http.MultipartFile.fromPath('image_profile', profile.path));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      Map<String, dynamic> json = jsonDecode(body);
      return json.toString();
    } else {
      debugPrint("=>> ${response.reasonPhrase}");
    }
    return "";
  }

  Future<UserModel?> fetchUserProfileRepo({String? newToken}) async {
    UserModel? user;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${newToken ?? accessToken.$}'
    };
    var request = http.Request(
        'GET', Uri.parse('${AppConstant.domainKey}/api/auth/get-me'));

    request.headers.addAll(headers);

    debugPrint("token ${accessToken.$}");

    http.StreamedResponse response = await request.send();
    var body = await response.stream.bytesToString();
    debugPrint("statusCode ${response.statusCode}");
    if (response.statusCode == 200) {
      var json = jsonDecode(body);
      user = UserModel.fromJson(json);
      return user;
    } else {
      debugPrint(response.reasonPhrase);
    }
    return null;
  }

  Future<String> refreshToken() async {
    var headers = {
      'Authorization':
          'Bearer ${accessToken.$}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${AppConstant.domainKey}/api/auth/refresh'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var body = await response.stream.bytesToString();

    debugPrint("response.statusCode ${response.statusCode}");
    if (response.statusCode == 200) {
      Map<String, dynamic> newToken = jsonDecode(body);
      return newToken['access_token'].toString();
    } else {
      debugPrint(response.reasonPhrase);
    }
    return "";
  }
}
