import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/more/widgets/more_list_tile_items.dart';
import 'package:legend_cinema/modules/auth/view/auth_page.dart';
import 'package:legend_cinema/modules/auth/view/reqister_view.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/landings/more/widgets/learn_more_widget.dart';
import 'package:legend_cinema/shared/v_globle.dart';
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
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: accessToken.$.isEmpty,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLoginButton(),
                    const Gap(12),
                    _buildSignupButton(),
                  ],
                ),
              ),
              const Gap(20),
              _buildWishCard(),
              const Gap(12),
              _buildCustomListTile()
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignupButton(){
    return GestureDetector(
      onTap: () => AppRoute().push(context, const Register()),
      child: Stack(
        children: [
          Container(
            height: 45,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.red.shade900,
              borderRadius: const BorderRadius.all(Radius.circular(40))
            ),
          ),
          Positioned(
            left: 20,
            bottom: -14,
            child: SizedBox(
              height: 80,
              width: 80,
              child: Image.asset(AssetPath.signupicon)
            )
          ),
          Positioned(
            right: 50,
            bottom: 14,
            child: TextWidget(
              S.of(context).register,
              bold: true,
            )
          )
        ],
      ),
    );
  }

  Widget _buildLoginButton(){
    return GestureDetector(
      onTap: () => AppRoute().push(context, const AuthPage()),
      child: Stack(
        children: [
          Container(
            height: 45,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.red.shade900,
              borderRadius: const BorderRadius.all(Radius.circular(40))
            ),
          ),
          Positioned(
            left: 35,
            top: -14,
            child: SizedBox(
              height: 70,
              width: 70,
              child: Image.asset(AssetPath.loginicon)
            )
          ),
          Positioned(
            right: 55,
            bottom: 14,
            child: TextWidget(
              S.of(context).login,
              bold: true,
            )
          )
        ],
      ),
    );
  }

  Widget _buildWishCard(){
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: Colors.white.withOpacity(0.2))
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                      S.of(context).lengend_membership, 
                      size: 20, 
                      bold: true,
                    )
                  ),
                    const Gap(12),
                  TextWidget(
                    S.of(context).dis_legend_membership, 
                    size: 13,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  const Gap(40),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                      onPressed: () => AppRoute().push(context, const LearnMoreWidget()), 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade900,
                      ),
                      child: TextWidget(
                        S.of(context).learn_more,
                        size: 14,
                        bold: true,
                      ),
                    ),
                  ),
                  const Gap(8),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -27,
          right: 8,
          child: Container(
            height: 180,
            width: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)),
              image: DecorationImage(image: AssetImage(AssetPath.cardGift))
            ),
          )
        ),
      ],
    );
  }

  Widget _buildCustomListTile(){
    final MoreController languageController = Get.find();
    return Obx(() {
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
    });
  }
}