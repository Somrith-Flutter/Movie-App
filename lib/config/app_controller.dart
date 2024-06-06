import 'package:get/get.dart';
import 'package:legend_cinema/modules/landings/home/controller/home_controller.dart';
import 'package:legend_cinema/modules/landings/home/repository/home_repository.dart';

class AppController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
      repository: HomeRepository())
    );
  }
}
