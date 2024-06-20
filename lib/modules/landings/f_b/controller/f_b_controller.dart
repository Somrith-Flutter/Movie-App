import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/core/double_format.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/core/model/fb_from_service_model.dart';
import 'package:legend_cinema/core/model/fb_model.dart';
import 'package:legend_cinema/modules/landings/f_b/model/location_model.dart';
import 'package:legend_cinema/modules/landings/f_b/repository/f_b_repository.dart';

class FBController extends GetxController implements GetxService {
  FBController({required this.repository});
  final FBRepository repository;

  final Map<FBFromServiceModel, int> cartItems = {};
  List<FANDBModel> fb = [];
  List<FBFromServiceModel> fbs = [];
  BaseStatusEnum status = BaseStatusEnum.initial;
  final textController = TextEditingController(text: "");

  void addItem(FBFromServiceModel product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
      update();
    } else {
      cartItems[product] = 1;
      update();
    }
  }

  void removeItem(FBFromServiceModel product) {
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

  int getProductQuantity(FBFromServiceModel product) {
    return cartItems[product]?.toInt() ?? 0;
  }

  int get totalItems =>
      cartItems.values.fold(0, (sum, item) => sum + item.toInt());

  double get totalPrice => cartItems.entries.fold(0.0, (sum, entry) {
    final price = entry.key.price ?? 0.0;
    final quantity = entry.value;
    final itemTotal = price * quantity;
    debugPrint('Item Price: $price, Quantity: $quantity, Item Total: $itemTotal');
    return sum + itemTotal;
  });

  String get formattedTotalPrice => totalPrice.decimalized;

  var location = <LocationModel>[].obs;
  var isLoading = true.obs;
  String errorMessage = '';

  @override
  void onInit() {
    super.onInit();
    getLocations();
    update();
  }

  Future<void> getLocations() async {
    status = BaseStatusEnum.inprogress;
    update();

    try {
      await repository.getLocationList().then((data) {
        if (data != null) {
          fb = data;
          status = BaseStatusEnum.success;
          debugPrint(fb.toString());
        } else {
          debugPrint("error");
        }
        update();
        return;
      });
    } catch (e) {
      status = BaseStatusEnum.failure;
      debugPrint(e.toString());
    }
    update();
  }

  void searchLocations(String query) {
    status = BaseStatusEnum.inprogress;
    update();

    if (fb.isNotEmpty) {
      fb = fb.where((location) {
        return location.name
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
      status = BaseStatusEnum.success;
      updateFilteredLocations(fb);
    } else {
      status = BaseStatusEnum.failure;
      updateFilteredLocations(fb);
    }
    update();
  }

  void updateFilteredLocations(List<FANDBModel> filteredLocations) {
    fb = filteredLocations;
    if (filteredLocations.isEmpty) {
      status = BaseStatusEnum.failure;
      update();
    } else {
      status = BaseStatusEnum.success;
    }
    debugPrint(filteredLocations.toString());
    update();
  }

  Future<void> getDetailedData(String locationType) async {
    status = BaseStatusEnum.inprogress;
    update();

    try {
      final response = await repository.getDetailedDataRepo(locationType);

      if (response != null) {
        fbs = response;
        status = BaseStatusEnum.success;
        debugPrint(fbs.toString());
      } else {
        debugPrint("error");
        status = BaseStatusEnum.failure;
      }
    } catch (e) {
      status = BaseStatusEnum.failure;
      errorMessage = e.toString();
      debugPrint(errorMessage);
    } finally {
      update();
    }
  }
}
