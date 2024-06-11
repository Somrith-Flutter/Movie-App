import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/modules/landings/f_b/model/card_model.dart';
import 'package:legend_cinema/modules/landings/f_b/repository/f_b_repository.dart';
import 'package:legend_cinema/modules/landings/f_b/widgets/f_b_cart_detail.dart';
import 'package:legend_cinema/widgets/animated_flipcounter_box.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class FAndBCombo extends StatefulWidget {
  const FAndBCombo({super.key});

  @override
  State<FAndBCombo> createState() => _FAndBComboState();
}

class _FAndBComboState extends State<FAndBCombo> {
  var cartController = Get.put(FBController(repository: FBRepository()));

  @override
  Widget build(BuildContext context) {
    final List<CartModel> cartItem = [
      CartModel(
        title: 'Combo 1',
        price: 5.0,
        imageUrl: 'assets/images/f&b.jpeg',
      ),
      CartModel(
        title: 'Combo 2',
        price: 4.50,
        imageUrl: 'assets/images/f&b.jpeg',
      ),
      CartModel(
        title: 'Combo 3',
        price: 4.80,
        imageUrl: 'assets/images/f&b.jpeg',
      ),
      CartModel(
        title: 'Combo 4',
        price: 5.50,
        imageUrl: 'assets/images/f&b.jpeg',
      ),
      CartModel(
        title: 'Combo 5',
        price: 5.50,
        imageUrl: 'assets/images/f&b.jpeg',
      ),
      CartModel(
        title: 'Combo 6',
        price: 6.50,
        imageUrl: 'assets/images/f&b.jpeg',
      ),
      CartModel(
        title: 'Combo 7',
        price: 8.0,
        imageUrl: 'assets/images/f&b.jpeg',
      ),
      CartModel(
        title: 'Combo 8',
        price: 7.0,
        imageUrl: 'assets/images/f&b.jpeg',
      ),
    ];

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
            leading: const BackWidgetScreen(),
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
          body: GetBuilder<FBController>(builder: (logic) {
            return Column(
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
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        "Legend Premium Exchange Square",
                                        size: 16,
                                      ),
                                      Icon(
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItem.length,
                        itemBuilder: (context, index) {
                          var product = cartItem[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: SizedBox(
                              height: 130,
                              child: Card(
                                color: Colors.white70.withOpacity(0.1),
                                elevation: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.8)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              image: DecorationImage(
                                                image:
                                                AssetImage(product.imageUrl),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                TextWidget(
                                                  product.title,
                                                  size: 17,
                                                  bold: true,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                TextWidget(
                                                  "\$${product.price}",
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
                                              if (logic.getProductQuantity(
                                                  product) >
                                                  0)
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.red[600],
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      logic.removeItem(product);
                                                    },
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                              if (logic.getProductQuantity(
                                                  product) >
                                                  0)
                                                TextWidget(
                                                  "${logic.getProductQuantity(product)}",
                                                  size: 20,
                                                  bold: true,
                                                ),
                                              Container(
                                                margin:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red[600],
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Future.delayed(const Duration(seconds: 2));
                                                    logic.addItem(product);
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
                      ),
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
                                  const TextWidget("Summary", size: 16, bold: true),
                                  MyAnimatedFlipCounter(
                                    duration: const Duration(milliseconds: 500),
                                    value: double.parse(cartController.formattedTotalPrice),
                                    textStyle: const TextStyle(fontSize: 18),
                                    prefix: '\$',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              var selectedItems = cartItem.where((product) => logic.getProductQuantity(product) > 0).map((product) {
                                product.quantity = logic.getProductQuantity(product);
                                return product;
                              }).toList();
                              AppRoute.route.push(context, FBCartDetail(selectedItems: selectedItems));
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
            );
          }),
        ),
      ],
    );
  }
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
            const SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                itemCount: cinemaList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.red),
                            const SizedBox(width: 8),
                            TextWidget(cinemaList[index]["title"] ?? "",
                                size: 16, bold: true),
                          ],
                        ),
                        Divider(
                            color: Colors.white.withOpacity(0.3), height: 0.5),
                      ],
                    ),
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

List<Map<String, String>> cinemaList = [
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
