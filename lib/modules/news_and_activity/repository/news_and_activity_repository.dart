import 'dart:convert';
import 'package:legend_cinema/constants/api_path.dart';
import 'package:legend_cinema/core/service/rest_api_service.dart';
import 'package:legend_cinema/modules/news_and_activity/model/news_and_activity_model.dart';

class NewsAndActivityRepository extends RestApiService {
  NewsAndActivityRepository();
  
  Future<List<NewsAndActivityModel>> getNewsList() async {
    final response = await get(ApiPath.newslist);
    final Map<String, dynamic> jsonResponse = json.decode(response);
    final List<dynamic> data = jsonResponse['data'];
    return data.map((json) => NewsAndActivityModel.fromJson(json)).toList();
  }
}
