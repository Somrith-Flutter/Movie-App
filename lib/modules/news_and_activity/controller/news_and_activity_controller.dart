import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:legend_cinema/modules/news_and_activity/repository/news_and_activity_repository.dart';

class NewsAndActivityController extends GetxController{
  NewsAndActivityController({required this.repository});

  final NewsAndActivityRepository repository;
}