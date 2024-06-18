import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/modules/landings/home/model/home_model.dart';
import 'package:legend_cinema/modules/landings/home/repository/home_repository.dart';
import 'package:legend_cinema/modules/landings/home/widgets/movie_item.dart';
import 'package:legend_cinema/modules/landings/offers/model/offers_model.dart';
import 'package:legend_cinema/utils/helpers/date_helper.dart';
import 'package:legend_cinema/utils/helpers/helper_fn.dart';

class HomeController extends GetxController {
  HomeController({required this.repository});

  final HomeRepository repository;
  late Timer timer;
  String selectedDay = '';
  String selectedMonth = '';
  bool isNowShowing = true;
  int selectedIndex = 0;
  int currentPage = 0;
  Movies currentImagePath = pages.first;
  bool isTextTapSelected = true;
  final dateInfo = DateInfo();
  String cinema = '';
  List<MoiveModel> moive = [];
  BaseStatusEnum response = BaseStatusEnum.initial;

  Future<String> fetchMoiveController({String? location, String? id}) async {
    response = BaseStatusEnum.inprogress;
    update();
    try {
      final repo =
          await repository.fetchMovieRepo(location: location ?? "", id: id);

      if (repo != null) {
        moive = repo;
        response = BaseStatusEnum.success;
        update();
      } else {
        response = BaseStatusEnum.failure;
        debugPrint("==========Error");
      }
    } catch (e) {
      debugPrint("error $e");
    } finally {
      update();
    }
    update();
    return "";
  }

  var offers = <OfferModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  Future<void> getPromotion() async {
    try {
      isLoading(true);
      errorMessage('');
      var items = await repository.getPromotion();
      offers.value = items;
      debugPrint('Fetched Offers: $items');
    } catch (e) {
      errorMessage.value = e.toString();
      debugPrint('Error fetching offers: $e');
    } finally {
      isLoading(false);
    }
  }
}