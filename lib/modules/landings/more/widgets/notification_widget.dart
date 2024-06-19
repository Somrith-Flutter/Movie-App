import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  final MoreController moreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(S.of(context).notification, size: 22, bold: true),
        centerTitle: true,
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: AppColor.primaryColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white.withOpacity(0.7)),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: SwitchListTile.adaptive(
        title: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Icons.notifications,
                size: 22,
                color: AppColor.chart2,
              ),
            ),
            const Gap(8),
            TextWidget(S.of(context).notification),
          ],
        ),
        value: moreController.isOpen.value,
        onChanged: (con) {
          setState(() {
            moreController.saveNotificationState(con);
          });
        },
      ),
    );
  }
}
