import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legend_cinema/constants/app_constant.dart';
class AuthRepository {

  Future<dynamic> loginRepo({
    required String type,
    required String? email,
    required String? phone,
    required String password}) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${AppConstant.domainKey}/api/auth/login/$type'));
    request.body =
        json.encode({
          type == "email" ? "email" : "phone" : type == "email" ? email : phone, 
          "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      debugPrint(jsonDecode(body));
      return jsonDecode(body);
    }
    return null;
  }
}
