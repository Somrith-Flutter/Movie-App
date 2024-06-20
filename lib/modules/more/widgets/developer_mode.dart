import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/modules/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/more/widgets/more_list_tile_items.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/list_tile_item.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
class DeveloperMode extends StatefulWidget {
  const DeveloperMode({super.key});

  @override
  State<DeveloperMode> createState() => _DeveloperModeState();
}

class _DeveloperModeState extends State<DeveloperMode> {
  late MoreController controller;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find();
    isOpen = controller.isDeveloperModeEnabled.value;
  }

  void _toggleDeveloperMode(bool value) async {
    if (!value) {
      await controller.disableDeveloperMode();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      await controller.enableDeveloperMode();
    }
    setState(() {
      isOpen = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(S.of(context).developer_mode, size: 22, bold: true),
        centerTitle: true,
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: AppColor.primaryColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // final auth = Get.find<AuthController>();
    return Column(
      children: [
        Container(
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
                    Icons.developer_mode,
                    size: 22,
                    color: AppColor.chart2,
                  ),
                ),
                const Gap(8),
                TextWidget(S.of(context).developer_mode),
              ],
            ),
            value: isOpen,
            onChanged: _toggleDeveloperMode,
          ),
        ),
        MyListTile(
          data: developerItem(context),
          onTap: (index) async{
            if (index >= 0 && index < developerItem(context).length) {
              var selectedItem = developerItem(context)[index];
              if(selectedItem.isRoute == true){
                if (selectedItem.route != null) {
                  AppRoute().push(context, selectedItem.route!);
                } else {}
              }
              // if(selectedItem.isRoute == false){
              //   await auth.logoutController();
              //   Future.delayed(const Duration(milliseconds: 100));
              //   AppRoute.route.push(context, const BottomNavigation());
              // }
            }
          }
        ),
      ],
    );
  }
}
