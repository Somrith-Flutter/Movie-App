import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legend_cinema/constants/app_constant.dart';

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
          debugPrint('Unexpected response format');
          return null;
        }
        
      } catch (e) {
        debugPrint('Error decoding JSON: $e');
        return null;
      }
    } else {
      debugPrint('Request failed with status: ${response.statusCode}');
      return null;
    }
  }
}
