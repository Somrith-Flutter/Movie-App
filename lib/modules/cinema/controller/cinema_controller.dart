import 'package:get/get.dart';
import 'package:legend_cinema/modules/cinema/repository/cinema_repository.dart';

class CinemaController extends GetxController{
  CinemaController({required this.repository});

   final CinemaRepository repository;
}