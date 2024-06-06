import 'package:get/get.dart';
import 'package:legend_cinema/modules/landings/home/repository/home_repository.dart';

class HomeController extends GetxController{
  HomeController({required this.repository});

  final HomeRepository repository;
}