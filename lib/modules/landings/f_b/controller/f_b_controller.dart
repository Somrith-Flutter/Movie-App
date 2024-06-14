import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:legend_cinema/constants/api_path.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/core/model/fb_model.dart';
import 'package:legend_cinema/modules/landings/f_b/model/card_model.dart';
import 'package:legend_cinema/modules/landings/f_b/model/f_b_model.dart';
import 'package:legend_cinema/modules/landings/f_b/model/location_model.dart';
import 'package:legend_cinema/modules/landings/f_b/repository/f_b_repository.dart';

class FBController extends GetxController implements GetxService{
  FBController({required this.repository});
  final FBRepository repository;

  final Map<CartModel, int> cartItems = {};
  List<FANDBModel> fb = [];
  BaseStatusEnum status = BaseStatusEnum.initial;

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

  var location = <LocationModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getLocations();
  }

  Future<void> getLocations() async {
    status = BaseStatusEnum.inprogress;

    try {
      await repository.getLocationList().then((data) {
        if(data != null){
          fb = data;
        }
        status = BaseStatusEnum.success;
      });
    } catch (e) {
      status = BaseStatusEnum.failure;
      debugPrint(e.toString());
    }
    update();
  }

   var detailedData = <FBModel>[].obs;

  Future<void> getDetailedData(String locationType) async {
    try {
      isLoading(true);
      final response = await repository.getDetailedData(ApiPath.locationlistdata, locationType);
      // Update the detailedData variable with the fetched data
      detailedData.value = response as List<FBModel>;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}