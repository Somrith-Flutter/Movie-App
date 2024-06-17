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
import 'package:shared_preferences/shared_preferences.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  int _clickCount = 0;
  late MoreController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _clickCount = prefs.getInt('clickCount') ?? 0;
      controller.isDeveloperModeEnabled.value = prefs.getBool('developerModeEnabled') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('clickCount', _clickCount);
  }

  void _onTitleTap() async {
    setState(() {
      _clickCount++;
      if (_clickCount == 7) {
        controller.enableDeveloperMode();
        _clickCount = 0;
      }
    });
    await _savePreferences();
    debugPrint('${controller.isDeveloperModeEnabled.value ? controller.developerCode : 0}');
  }
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoreController>(
      init: MoreController(repository: MoreRepository()),
      initState: (_) => Get.find<MoreController>().onInit(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title:  GestureDetector(
            onTap: _onTitleTap,
            child: TextWidget(S.of(context).account, size: 22, bold: true),
          ),
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