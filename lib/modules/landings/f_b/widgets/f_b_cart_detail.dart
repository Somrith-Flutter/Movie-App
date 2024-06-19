import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/core/model/fb_from_service_model.dart';
import 'package:legend_cinema/modules/landings/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/modules/landings/f_b/widgets/f_b_payment.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/animated_flipcounter_box.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class FBCartDetail extends StatefulWidget {
  final List<FBFromServiceModel> selectedItems;
  final String selectedCinema;
  const FBCartDetail(
      {super.key, required this.selectedItems, required this.selectedCinema});

  @override
  State<FBCartDetail> createState() => _FBCartDetailState();
}

class _FBCartDetailState extends State<FBCartDetail> {
  var cartController = Get.find<FBController>();

  @override
  void initState() {
    super.initState();
  }

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
          body: GetBuilder<FBController>(
            builder: (logic) {
              return Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(S.of(context).order_summary,
                                  size: 17.0, bold: true),
                              const Gap(15.0),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.8)),
                                  color: Colors.white70.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextWidget(
                                  widget.selectedCinema.toUpperCase(),
                                  size: 16.0,
                                  bold: true,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Builder(
                                builder: (context) {
                                  const double itemHeight = 123.00;
                                  final filteredItems = widget.selectedItems
                                      .where((item) =>
                                          logic.getProductQuantity(item) > 0)
                                      .toList();
                                  final double totalHeight =
                                      itemHeight * filteredItems.length;
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: totalHeight >
                                                MediaQuery.of(context)
                                                    .size
                                                    .height
                                            ? MediaQuery.of(context).size.height
                                            : totalHeight,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white
                                                    .withOpacity(0.8)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ListView.builder(
                                            physics: totalHeight >
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height
                                                ? const BouncingScrollPhysics()
                                                : const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: filteredItems.length,
                                            itemBuilder: (context, index) {
                                              final item = filteredItems[index];
                                              String cacheImage({String? img}){
                                                if (AppConstant.baseIosIP == AppConstant.domainKey ){
                                                  img = item.imageUrl;
                                                }
                                                if (AppConstant.baseAndroidIP == AppConstant.domainKey){
                                                  img = "${AppConstant.domainKey}/${item.imageUrl.toString()}";
                                                  debugPrint(img);
                                                }
                                                return img ?? '';
                                              }
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(5),
                                                        child: CachedNetworkImage(
                                                          width: double.maxFinite,
                                                          height: double.maxFinite,
                                                          fit: BoxFit.cover,
                                                          imageUrl: cacheImage(),
                                                          placeholder: (context, url) => const Center(
                                                            child: CupertinoActivityIndicator(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          TextWidget(
                                                            item.title,
                                                            size: 16.0,
                                                            bold: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          const Gap(50.0),
                                                          TextWidget(
                                                            "\$${item.price?.toStringAsFixed(2)}",
                                                            size: 16,
                                                            bold: true,
                                                            color: Colors.red,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Row(
                                                        children: [
                                                          if (logic.getProductQuantity(item) > 0)
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .red[600],
                                                              ),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  logic
                                                                      .removeItem(
                                                                          item);
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons.remove,
                                                                  size: 30,
                                                                ),
                                                              ),
                                                            ),
                                                          if (logic
                                                                  .getProductQuantity(
                                                                      item) >
                                                              0)
                                                            TextWidget(
                                                              "${logic.getProductQuantity(item)}",
                                                              size: 20,
                                                              bold: true,
                                                            ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        8),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Colors
                                                                  .red[600],
                                                            ),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Future.delayed(
                                                                    const Duration(
                                                                        seconds:
                                                                            2));
                                                                logic.addItem(
                                                                    item);
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
                                                                size: 30,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: 100,
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0, top: 8.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.red),
                                              child: Center(
                                                  child: TextWidget(
                                                S.of(context).total,
                                                size: 16.0,
                                                bold: true,
                                              ))),
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0, top: 8.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.red),
                                            child: MyAnimatedFlipCounter(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              value: double.parse(cartController
                                                  .formattedTotalPrice),
                                              textStyle: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                              prefix: '\$',
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      double totalPrice =
                          double.parse(cartController.formattedTotalPrice);
                      AppRoute.route.push(
                          context,
                          FBPayment(
                            totalPrice: totalPrice,
                            items: widget.selectedItems,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.red),
                        child: Center(
                            child: TextWidget(
                          S.of(context).checkout,
                          size: 16.0,
                        )),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
