import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/landings/more/repository/more_repository.dart';
import 'package:legend_cinema/modules/landings/more/view/more_view.dart';
import 'package:legend_cinema/modules/landings/more/widgets/profile_widget.dart';
import 'package:legend_cinema/shared/v_globle.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoreController>(
      init: MoreController(repository: MoreRepository()),
      initState: (_) => Get.find<MoreController>().onInit(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: TextWidget(S.of(context).account, size: 22, bold: true,),
          flexibleSpace: AppConstant.appbarTheme,
          actions: [
            if(accessToken.$.isNotEmpty)...[
              GestureDetector(
                onTap: () => AppRoute().push(context, const ProfileWidget()),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ]
          ],
        ),
        backgroundColor: AppColor.primaryColor,
        body: const MoreView(),
      ),
    );
  }
}