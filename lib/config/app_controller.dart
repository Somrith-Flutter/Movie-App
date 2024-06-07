import 'package:get/get.dart';
import 'package:legend_cinema/modules/landings/cinema/controller/cinema_controller.dart';
import 'package:legend_cinema/modules/landings/cinema/repository/cinema_repository.dart';
import 'package:legend_cinema/modules/landings/f&b/controller/f&b_controller.dart';
import 'package:legend_cinema/modules/landings/f&b/repository/f&b_repository.dart';
import 'package:legend_cinema/modules/landings/home/controller/home_controller.dart';
import 'package:legend_cinema/modules/landings/home/repository/home_repository.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/landings/more/repository/more_repository.dart';
import 'package:legend_cinema/modules/landings/offers/controller/offers_controller.dart';
import 'package:legend_cinema/modules/landings/offers/repository/offers_repository.dart';

class AppController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
      repository: HomeRepository())
    );
    Get.lazyPut(() => OffersController(
      repository: OffersRepository())
    );
    Get.lazyPut(() => CinemaController(
      repository: CinemaRepository()
    ));
    Get.lazyPut(() => FBController(
      repository: FBRepository()
    ));
    Get.lazyPut(() => MoreController(
      repository: MoreRepository()
    ));
  }
}
