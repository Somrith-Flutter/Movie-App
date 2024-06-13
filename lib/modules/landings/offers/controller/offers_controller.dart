import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/modules/landings/offers/model/offers_model.dart';
import 'package:legend_cinema/modules/landings/offers/repository/offers_repository.dart';

class OffersController extends GetxController{
  OffersController({required this.repository});

  final OffersRepository repository;

  var offers = <OfferModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  Future<void> fetchOffers() async {
  try {
    isLoading(true);
    errorMessage('');
    var items = await repository.getOffers();
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