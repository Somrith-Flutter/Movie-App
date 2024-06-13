import 'dart:convert';

import 'package:legend_cinema/constants/api_path.dart';
import 'package:legend_cinema/core/service/rest_api_service.dart';
import 'package:legend_cinema/modules/landings/offers/model/offers_model.dart';

class OffersRepository extends RestApiService{
  Future<List<OfferModel>> getOffers() async {
    final response = await get(ApiPath.offers);
    final Map<String, dynamic> jsonResponse = json.decode(response);
    final List<dynamic> data = jsonResponse['message'];
    return data.map((json) => OfferModel.fromJson(json)).toList();
  }
}