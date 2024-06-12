import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legend_cinema/constants/api_path.dart';
class AuthRepository {
  Future<String> loginRepo({
    required String type,
    required String email,
    required String password}) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${ApiPath.domainKey}/api/auth/login/$type'));
    request.body =
        json.encode({
          "email": email, 
          "password": password});
    request.headers.addAll(headers);

    debugPrint(email.toString());
    debugPrint(password.toString());

    http.StreamedResponse response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      debugPrint(body);

      var json = jsonDecode(body);
      return json['access_token'];
    } else {
      debugPrint(response.reasonPhrase);
    }

    return "";
  }
}
