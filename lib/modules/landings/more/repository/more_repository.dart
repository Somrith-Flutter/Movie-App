import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:legend_cinema/constants/api_path.dart';
import 'package:legend_cinema/core/service/rest_api_service.dart';
import 'package:legend_cinema/modules/landings/more/model/about_model.dart';
import 'package:legend_cinema/modules/landings/more/model/news_model.dart';

class MoreRepository extends RestApiService{

  Future<List<NewsModel>> getNewsList() async {
    final response = await get(ApiPath.newslist);
    final Map<String, dynamic> jsonResponse = json.decode(response);
    final List<dynamic> data = jsonResponse['data'];
    debugPrint(data.toString());
    return data.map((json) => NewsModel.fromJson(json)).toList();
  }

  Future<List<AboutModel>> getAbout() async {
    final response = await get(ApiPath.aboutus);
    final Map<String, dynamic> jsonResponse = json.decode(response);
    debugPrint('Response: $jsonResponse');
    final List<dynamic> data = jsonResponse['messages'];
    return data.map((json) => AboutModel.fromJson(json)).toList();
  } 
}