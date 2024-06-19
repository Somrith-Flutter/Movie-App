import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/shared/v_globle.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
import 'package:get/get.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackWidget(),
          title: TextWidget(
            S.of(context).notification,
            size: 22,
            bold: true,
          ),
          flexibleSpace: AppConstant.appbarTheme,
          bottom: TabBar(
            tabs: [
              Tab(text: S.of(context).announcement),
              Tab(text: S.of(context).order),
            ],
            indicatorColor: Colors.red,
            unselectedLabelColor: Colors.white,
            labelColor: Colors.red,
          ),
        ),
        backgroundColor: Colors.black,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return TabBarView(
      children: [
        _buildAnnouncementTab(context),
        _buildOrdersTab(context),
      ],
    );
  }

  Widget _buildAnnouncementTab(BuildContext context) {
    final MoreController moreController = Get.find();

    return Column(
      children: [
        const Gap(100),
        SizedBox(
          height: 300,
          width: 300,
          child: Image.asset(AssetPath.purchase, fit: BoxFit.contain),
        ),
        const Gap(10),
        if (accessToken.$.isEmpty) ...[
          TextWidget(
            S.of(context).ms_notification,
            size: 20,
            color: Colors.grey,
          ),
        ],
        if (accessToken.$.isNotEmpty) ...[
          if (moreController.isOpen.value)
            Center(
              child: TextWidget(
                S.of(context).no_notification,
                size: 20,
                color: Colors.grey,
              ),
            )
          else
            Center(
              child: TextWidget(
                S.of(context).enable_notification,
                size: 20,
                color: Colors.grey,
              ),
            ),
        ]
      ],
    );
  }

  Widget _buildOrdersTab(BuildContext context) {
    final MoreController moreController = Get.find();

    return Column(
      children: [
        const Gap(100),
        SizedBox(
          height: 300,
          width: 300,
          child: Image.asset(AssetPath.purchase, fit: BoxFit.contain),
        ),
        if (accessToken.$.isEmpty) ...[
          TextWidget(
            S.of(context).ms_notification,
            size: 20,
            color: Colors.grey,
          ),
        ],
        if (accessToken.$.isNotEmpty) ...[
          if (moreController.isOpen.value)
            Center(
              child: TextWidget(
                S.of(context).no_notification,
                size: 20,
                color: Colors.grey,
              ),
            )
          else
            Center(
              child: TextWidget(
                S.of(context).enable_notification,
                size: 20,
                color: Colors.grey,
              ),
            ),
        ]
      ],
    );
  }
}
