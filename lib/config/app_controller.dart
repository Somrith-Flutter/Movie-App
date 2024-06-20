import 'package:get/get.dart';
import 'package:legend_cinema/modules/auth/controller/auth_controller.dart';
import 'package:legend_cinema/modules/auth/controller/pick_image_controller.dart';
import 'package:legend_cinema/modules/auth/repository/auth_repository.dart';
import 'package:legend_cinema/modules/cinema/controller/cinema_controller.dart';
import 'package:legend_cinema/modules/cinema/repository/cinema_repository.dart';
import 'package:legend_cinema/modules/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/modules/f_b/repository/f_b_repository.dart';
import 'package:legend_cinema/modules/home/controller/home_controller.dart';
import 'package:legend_cinema/modules/home/repository/home_repository.dart';
import 'package:legend_cinema/modules/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/more/repository/more_repository.dart';
import 'package:legend_cinema/modules/offers/controller/offers_controller.dart';
import 'package:legend_cinema/modules/offers/repository/offers_repository.dart';

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
    Get.lazyPut(() => FBController(repository: FBRepository()));
    Get.lazyPut(() => MoreController(
      repository: MoreRepository()
    ));
    Get.lazyPut(() => AuthController(
      repository: AuthRepository()
    ));
    Get.put(PickImageController());
  }
}
