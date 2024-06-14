import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/modules/landings/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/modules/landings/f_b/repository/f_b_repository.dart';
import 'package:legend_cinema/modules/landings/f_b/widgets/f_b_combo.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'dart:ui';
import 'package:legend_cinema/widgets/text_widget.dart';

final controller = Get.put(FBController(repository: FBRepository()));

class FBView extends StatefulWidget {
  const FBView({super.key});

  @override
  State<FBView> createState() => _FBViewState();
}

class _FBViewState extends State<FBView> {
  final controller = Get.put(FBController(repository: FBRepository()));

  @override
  Widget build(BuildContext context) {
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
            body: GetBuilder<FBController>(
              builder: (logic) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      _buildBody(context),
                      _buildListMovieLocation(),
                    ],
                  ),
                );
              }
            )
          ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
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
    return GetBuilder<FBController>(
      builder: (logic) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.fb.length,
          itemBuilder: (context, index) {
            if(controller.status == BaseStatusEnum.inprogress){
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
        
            if(controller.status == BaseStatusEnum.failure){
              return const Center(
                child: Text("No data!")
              );
            }
            
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: SizedBox(
                height: 80,
                child: GestureDetector(
                  onTap: () => AppRoute.route.push(context, const FAndBCombo()),
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
                                width: 60,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      logic.fb[index].image.toString(),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextWidget(
                                controller.fb[index].name.toString(),
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
        );
      }
    );
  }
}
