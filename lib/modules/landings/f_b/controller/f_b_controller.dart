import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:legend_cinema/modules/landings/f_b/model/card_model.dart';
import 'package:legend_cinema/modules/landings/f_b/repository/f_b_repository.dart';

class FBController extends GetxController{
  FBController({required this.repository});
  final FBRepository repository;

  final Map<CartModel, int> cartItems = {};

  void addItem(CartModel product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
      update();
    } else {
      cartItems[product] = 1;
      update();
    }
  }

  void removeItem(CartModel product) {
    if (cartItems.containsKey(product) && cartItems[product]! > 1) {
      cartItems[product] = cartItems[product]! - 1;
      update();
    } else {
      cartItems.remove(product);
      update();
    }
  }

  void clearCart() {
    cartItems.clear();
    update();
  }

  int getProductQuantity(CartModel product) {
    return cartItems[product]?.toInt() ?? 0;
  }

  int get totalItems => cartItems.values.fold(0, (sum, item) => sum + item.toInt());

 double get totalPrice => cartItems.entries.fold(0.0, (sum, entry) {
    return sum + (entry.key.price * entry.value);
  });

  String get formattedTotalPrice => NumberFormat('#,##0.00').format(totalPrice);
}