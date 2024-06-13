import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/core/more_list_tile_items.dart';
import 'package:legend_cinema/modules/auth/view/auth_page.dart';
import 'package:legend_cinema/modules/auth/view/reqister_view.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/widgets/list_tile_item.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class MoreView extends StatefulWidget {
  const MoreView({super.key});

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {

  @override
  Widget build(BuildContext context) {
    final MoreController languageController = Get.find();
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(S.of(context).account),
              const Gap(8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => AppRoute().push(context, const AuthPage()), 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red
                      ),
                      child: TextWidget(
                        S.of(context).login,
                      )
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => AppRoute().push(context, const Register()), 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red
                      ),
                      child: TextWidget(
                        S.of(context).register,
                      )
                    ),
                  ),
                ],
              ),
              Card(
                margin: const EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextWidget(S.of(context).lengend_membership, size: 20,)),
                        const Gap(12),
                      TextWidget(S.of(context).dis_legend_membership, size: 12,),
                      const Gap(24),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ElevatedButton(
                          onPressed: (){}, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: TextWidget(
                            S.of(context).learn_more,
                            size: 12,
                            bold: true,
                          ),
                        ),
                      ),
                      const Gap(8),
                    ],
                  ),
                ),
              ),
              Obx(() {
                String title;
                String icon;
                switch (languageController.currentLocale.value.languageCode) {
                  case AppConstant.km:
                    title = S.of(context).khmer;
                    icon = AssetPath.flagkhmer;
                    break;
                  case AppConstant.zh:
                    title = S.of(context).chinese;
                    icon = AssetPath.flagChinese;
                    break;
                  default:
                    title = S.of(context).english;
                    icon = AssetPath.flagEngland;
                    break;
                }
                return MyListTile(
                  data: items(context, title, icon),
                  onTap: (index) {
                    if (index >= 0 && index < items(context, title, icon).length) {
                      var selectedItem = items(context, title, icon)[index];
                      if (selectedItem.route != null) {
                        AppRoute().push(context, selectedItem.route!);
                      } else {
                      }
                    }
                  }
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}