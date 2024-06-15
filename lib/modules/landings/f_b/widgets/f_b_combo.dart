import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/modules/landings/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/modules/landings/f_b/view/f_b_view.dart';
import 'package:legend_cinema/widgets/animated_flipcounter_box.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/no_data_found.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class FAndBCombo extends StatefulWidget {
  const FAndBCombo(
      {super.key, required this.location, required this.selectedCinema});
  final String location;
  final String selectedCinema;

  @override
  State<FAndBCombo> createState() => _FAndBComboState();
}

class _FAndBComboState extends State<FAndBCombo> {
  final cartController = Get.find<FBController>();
  String cinema = '';

  @override
  void initState() {
    Future.delayed((Duration.zero), () {
      cartController.getDetailedData(widget.location.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FBController>(builder: (logic) {
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
                title: TextWidget(S.of(context).fb, size: 20, bold: true),
                centerTitle: true,
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
                    flex: 7,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Stack(
                          children: [
                            Image.asset(AssetPath.fbhero),
                            Positioned(
                              top: 16,
                              left: 16,
                              right: 16,
                              child: GestureDetector(
                                onTap: () {
                                  _buildBottomSheet(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black54.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                          cinema == "" ? widget.selectedCinema : cinema,
                                          size: 16,
                                        ),
                                        const Icon(
                                          Icons.arrow_drop_down_circle_outlined,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: _buildCambo(),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextWidget(
                                    "${cartController.totalItems}",
                                    textAlign: TextAlign.center,
                                    size: 19,
                                    bold: true,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const TextWidget("Summary",
                                        size: 16, bold: true),
                                    MyAnimatedFlipCounter(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      value: double.parse(
                                          cartController.formattedTotalPrice),
                                      textStyle: const TextStyle(fontSize: 18),
                                      prefix: '\$',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Your logic for the Continue button goes here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const TextWidget("Continue",
                                  size: 16, bold: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      );
    });
  }

  Future _buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 500,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(
                      "Cinema",
                      size: 19,
                      bold: true,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white.withOpacity(0.3), width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  color: Colors.white.withOpacity(0.3),
                  height: 2,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: cartController.fb.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              cinema = cartController.fb[index].name.toString();
                              controller.getDetailedData(cartController.fb[index].locationType.toString());
                            });
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.red),
                                  const SizedBox(width: 8),
                                  TextWidget(
                                    cartController.fb[index].name.toString(),
                                    size: 16,
                                    bold: true,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Divider(
                                  color: Colors.white.withOpacity(0.3),
                                  height: 0.5),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCambo() {
    if (cartController.status == BaseStatusEnum.failure) {
      return const NoDataFound();
    }

    if (cartController.status == BaseStatusEnum.inprogress) {
      return const Padding(
        padding: EdgeInsets.only(top: 200.0),
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartController.fbs?.length,
      itemBuilder: (context, index) {
        var product = cartController.fbs?[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SizedBox(
            height: 130,
            child: Card(
              color: Colors.white70.withOpacity(0.1),
              elevation: 2,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.8)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                "${AppConstant.domainKey}/${product?.imageUrl.toString()}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                product?.title,
                                size: 17,
                                bold: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                              TextWidget(
                                "\$${product?.price}",
                                size: 16,
                                bold: true,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: [
                            if (cartController.getProductQuantity(product!) > 0)
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red[600],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    cartController.removeItem(product);
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    size: 30,
                                  ),
                                ),
                              ),
                            if (cartController.getProductQuantity(product) > 0)
                              TextWidget(
                                "${cartController.getProductQuantity(product)}",
                                size: 20,
                                bold: true,
                              ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red[600],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Future.delayed(const Duration(seconds: 2));
                                  cartController.addItem(product);
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

var cinemaList = [
  {"title": "Legend Eden Garden"},
  {"title": "Legend Toul Kork"},
  {"title": "Legend Premium Exchange Square"},
  {"title": "Legend Olympia"},
  {"title": "Legend SenSok"},
  {"title": "Legend Noro Mall"},
  {"title": "Legend Midtown Mall"},
  {"title": "Legend Meanchey"},
  {"title": "Legend Cinema 271 Mega Mall"},
  {"title": "Legend K Mall"},
  {"title": "Legend Cinema Sihanoukville"},
  {"title": "Legend Siem Reap"},
];
