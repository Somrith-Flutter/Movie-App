import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/modules/landings/f_b/repository/f_b_repository.dart';
import 'package:legend_cinema/modules/landings/f_b/widgets/f_b_combo.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'dart:ui';
import 'package:legend_cinema/widgets/text_widget.dart';

class FBView extends StatelessWidget {
  const FBView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FBController(repository: FBRepository()));
    return Stack(
      children: [
        Image.asset(
          AssetPath.fbhero,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: AppColor.primaryColor.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: false,
            title: TextWidget(S.of(context).fb, size: 20, bold: true),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColor.appbarColor,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.errorMessage.isNotEmpty) {
              return Center(child: Text('Error: ${controller.errorMessage}'));
            } else if (controller.location.isEmpty) {
              return const Center(child: Text('No data available.'));
            } else {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Image.asset(AssetPath.fbhero),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 12, left: 12),
                    child: TextWidget(
                      S.of(context).choose_cinema,
                      size: 20,
                      bold: true,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.location.length,
                    itemBuilder: (context, index) {
                      final location = controller.location[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: SizedBox(
                          height: 80,
                          child: GestureDetector(
                            onTap: () => AppRoute.route.push(context, const FAndBCombo()),
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
                                          width: 60,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                location.image!,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: TextWidget(
                                          location.name,
                                          size: 16,
                                          bold: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 12.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          }),
        ),
      ],
    );
  }
}
