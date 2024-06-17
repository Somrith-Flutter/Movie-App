import 'dart:async';

import 'package:get/get.dart';
import 'package:legend_cinema/modules/landings/home/repository/home_repository.dart';
import 'package:legend_cinema/modules/landings/home/widgets/movie_item.dart';
import 'package:legend_cinema/utils/helpers/date_helper.dart';

class HomeController extends GetxController{
  HomeController({required this.repository});

  final HomeRepository repository;
  late Timer timer;
  String selectedDay = '';
  String selectedMonth = '';
  bool isNowShowing = true;
  int selectedIndex = 0;
  int currentPage = 0;
  String currentImagePath = images.first;
  bool isTextTapSelected = true;
  final dateInfo = DateInfo();
  String cinema = '';
}