import 'package:get/get.dart';
import 'package:legend_cinema/modules/landings/offers/repository/offers_repository.dart';

class OffersController extends GetxController{
  OffersController({required this.repository});

  final OffersRepository repository;
}