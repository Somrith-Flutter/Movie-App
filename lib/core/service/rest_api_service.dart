import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:legend_cinema/constants/app_constant.dart';

class RestApiService {

  Future<String> get(String endpoint) async {
    final response = await http.get(Uri.parse('${AppConstant.baseIosUrl}/$endpoint'));
    return _processResponse(response);
  }

  Future<String> getAssetData(String endpoint) async {
    return await rootBundle.loadString(endpoint);
  }

  Future<String> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('${AppConstant.baseIosUrl}/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  Future<String> put(String endpoint, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$hashCode/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  Future<String> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('${AppConstant.baseIosUrl}/$endpoint'));
    return _processResponse(response);
  }

  String _processResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}


// String _getBaseUrl() {
  //   if (kIsWeb) {
  //     return AppConstant.baseIosUrl;
  //   } else {
  //     return AppConstant.baseAndroidUrl;
  //   }
  // }
  // @override
  // String getBaseUrl() {
  //   if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
  //     return AppConstant.baseIosUrl;
  //   } else {
  //     return AppConstant.baseAndroidUrl;
  //   }
  // }
