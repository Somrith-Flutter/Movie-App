import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/modules/f_b/widgets/f_b_combo.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/no_data_found.dart';
import 'dart:ui';
import 'package:legend_cinema/widgets/text_widget.dart';

final controller = Get.find<FBController>();

class FBView extends StatefulWidget {
  const FBView({super.key});

  @override
  State<FBView> createState() => _FBViewState();
}

class _FBViewState extends State<FBView> {
  final controller = Get.find<FBController>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FBController>(
      builder: (logic) {
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
                key: _key,
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
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      _buildBody(context),
                      _buildListMovieLocation(),
                      const Gap(100)
                    ],
                  ),
                ))
          ],
        );
      }
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
      ],
    );
  }

  Widget _buildListMovieLocation() {
    if (controller.fb.isEmpty) {
      return const NoDataFound();
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.fb.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SizedBox(
            height: 80,
            child: GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => FAndBCombo(
                        location:
                            controller.fb[index].locationType.toString(),
                            selectedCinema: controller.fb[index].name.toString(),
                          )
                        )
                      );
              },
              child: Card(
                color: Colors.white70.withOpacity(0.1),
                elevation: 2,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 70,
                          margin: const EdgeInsets.only(right: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: AssetImage(
                                controller.fb[index].image.toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextWidget(
                            controller.fb[index].name.toString(),
                            size: 16,
                            bold: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Center(
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
    );
  }
}
