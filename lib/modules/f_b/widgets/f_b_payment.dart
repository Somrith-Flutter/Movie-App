import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/core/service/fb_from_service_model.dart';
import 'package:legend_cinema/modules/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/modules/more/controller/more_controller.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class FBPayment extends StatefulWidget {
  FBPayment({
    super.key, 
    required this.totalPrice,
    this.items,
    this.totalItems,
  });
  double totalPrice;
  String? totalItems;
  final List<FBFromServiceModel>? items;

  @override
  State<FBPayment> createState() => _FBPaymentState();
}

class _FBPaymentState extends State<FBPayment> {
  var cartController = Get.find<FBController>();
  String _selectedPaymentMethod = 'KHQR';


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/f&b.jpeg",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: const BackWidget(),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(S.of(context).checkout, size: 20, bold: true),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white.withOpacity(0.8)),
                            color: Colors.white70.withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(S.of(context).gust_info,
                                    size: 20, bold: true),
                                TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email,
                                        color: Colors.white.withOpacity(0.8)),
                                    labelText: S.of(context).email,
                                    labelStyle:
                                        TextStyle(color: Colors.white.withOpacity(0.8)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0.8)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white70.withOpacity(0.1),
                                  ),
                                  style:
                                      TextStyle(color: Colors.white.withOpacity(0.8)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white.withOpacity(0.8)),
                            color: Colors.white70.withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).payment_method,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/member-card.png",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          S.of(context).member_point,
                                          size: 16,
                                          bold: true,
                                          color: Colors.grey,
                                        ),
                                        TextWidget(S.of(context).available, color: Colors.grey, size: 12,),
                                      ],
                                    ),
                                    const Spacer(),
                                    Radio<String>(
                                      value: 'Member points',
                                      groupValue: _selectedPaymentMethod,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _selectedPaymentMethod = value!;
                                        });
                                      },
                                      activeColor: Colors.white70,
                                      fillColor: MaterialStateProperty.all(Colors.red),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.white.withOpacity(0.5),
                                  height: 3,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        "assets/icons/khqr.png",
                                        width: 50,
                                        fit: BoxFit.cover,
                                        height: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const TextWidget(
                                          "ABA KHQR",
                                          size: 16,
                                          bold: true,
                                          color: Colors.grey,
                                        ),
                                        TextWidget(
                                          S.of(context).scan_to_pay,
                                          size: 12,
                                          color: Colors.grey
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Radio<String>(
                                      value: 'KHQR',
                                      groupValue: _selectedPaymentMethod,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _selectedPaymentMethod = value!;
                                        });
                                      },
                                      activeColor: Colors.white,
                                      fillColor: MaterialStateProperty.all(Colors.red),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.white.withOpacity(0.5),
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/credit-card.png",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const TextWidget(
                                          "Debit/Credit Card",
                                          size: 16,
                                          bold: true,
                                          color: Colors.grey,
                                        ),
                                        TextWidget(S.of(context).available, color: Colors.grey, size: 12,),
                                      ],
                                    ),
                                    const Spacer(),
                                    Radio<String>(
                                      value: 'Credit Card',
                                      groupValue: _selectedPaymentMethod,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _selectedPaymentMethod = value!;
                                        });
                                      },
                                      activeColor: Colors.white70,
                                      fillColor: MaterialStateProperty.all(Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  EasyLoading.show(status: S.of(context).loading);
                  await Future.delayed(const Duration(seconds: 1));
                  EasyLoading.dismiss(); 
                  EasyLoading.showSuccess(S.of(context).payment_success);
                  setState(() {
                    cartController.cartItems.clear();
                  });
                  await _savePaymentDetails();
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.find<MoreController>().update();
                  Get.snackbar(S.of(context).ms_noti_pay, S.of(context).thanks_you);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(
                          "${S.of(context).pay} \$${widget.totalPrice.toStringAsFixed(2)}",
                          size: 16.0,
                          bold: true,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _savePaymentDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? paymentDataString = prefs.getString('paymentDataList');

    List<Map<String, dynamic>> paymentDataList = [];
    
    if (paymentDataString != null) {
      paymentDataList = List<Map<String, dynamic>>.from(jsonDecode(paymentDataString));
    }

    List<Map<String, dynamic>> itemsData = [];
    if (widget.items != null) {
      itemsData = widget.items!.map((item) => item.toJson()).toList();
    }

    Map<String, dynamic> paymentData = {
      'totalPrice': widget.totalPrice,
      'totalItem': widget.totalItems,
      'items': itemsData,
      'timestamp': DateTime.now().toIso8601String(),
    };

    paymentDataList.add(paymentData);

    await prefs.setString('paymentDataList', jsonEncode(paymentDataList));
  }

}
