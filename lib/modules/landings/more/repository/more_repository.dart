import 'dart:convert';

import 'package:legend_cinema/constants/api_path.dart';
import 'package:legend_cinema/core/service/rest_api_service.dart';
import 'package:legend_cinema/modules/landings/more/model/news_model.dart';

class MoreRepository extends RestApiService{

   Future<List<NewsModel>> getNewsList() async {
    final response = await get(ApiPath.newslist);
    final Map<String, dynamic> jsonResponse = json.decode(response);
    final List<dynamic> data = jsonResponse['data'];
    return data.map((json) => NewsModel.fromJson(json)).toList();
  }
}