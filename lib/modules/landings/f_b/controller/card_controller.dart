import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:legend_cinema/modules/landings/f_b/model/card_model.dart';


class CartController extends GetxController {
  var cartItems = <Product, int>{};

  void addItem(Product product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
      update();
    } else {
      cartItems[product] = 1;
      update();
    }
  }

  void removeItem(Product product) {
    if (cartItems.containsKey(product) && cartItems[product]! > 1) {
      cartItems[product] = cartItems[product]! - 1;
      update();
    } else {
      cartItems.remove(product);
      update();
    }
  }

  int getProductQuantity(Product product) {
    return cartItems[product] ?? 0;
  }

  int get totalItems => cartItems.values.fold(0, (sum, item) => sum + item);

  double get totalPrice => cartItems.entries.fold(0, (sum, entry) => sum + (entry.key.price * entry.value));
}
