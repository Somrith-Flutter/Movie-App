import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/shared/share_preference.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
   late bool isSelectedEnglish;
  late bool isSelectedKhmer;
  late bool isSelectedChinese;
  final MoreController languageController = Get.find();

  @override
  void initState() {
    super.initState();
    _loadSelectedLocale();
  }

  void _loadSelectedLocale() async {
  final selectedLanguage = await SharedPrefs.loadSelectedLanguage();
  setState(() {
    isSelectedEnglish = selectedLanguage.languageCode == AppConstant.en;
    isSelectedKhmer = selectedLanguage.languageCode == AppConstant.km;
    isSelectedChinese =
        selectedLanguage.languageCode == AppConstant.zh || selectedLanguage.languageCode == '';
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(S.of(context).language, size: 22, bold: true,),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: AppColor.primaryColor,
      body: _buildBody(), 
    );
  }

  Widget _buildBody(){
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 12, bottom: 8),
            child: TextWidget(S.of(context).language, size: 18,),
          )),
        _buildLanguageOption(
          context,
          AssetPath.flagEngland,
          S.of(context).english,
          AppConstant.en,
          AppConstant.us,
          isSelectedEnglish,
        ),
        _buildLanguageOption(
          context,
          AssetPath.flagkhmer,
          S.of(context).khmer,
          AppConstant.km,
          AppConstant.kh,
          isSelectedKhmer,
        ),
        _buildLanguageOption(
          context,
          AssetPath.flagChinese,
          S.of(context).chinese,
          AppConstant.zh,
          AppConstant.cn,
          isSelectedChinese,
        ),
      ],
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String flagAsset,
    String language,
    String languageCode,
    String countryCode,
    bool isSelected,
  ) {
    return Card(
      child: ListTile(
        leading: SizedBox(
          width: 50,
          height: 70,
          child: Image.asset(flagAsset),
        ),onTap: () => _saveLanguage(context, languageCode, countryCode),
        title: Text(language),
        trailing: isSelected ? const Icon(Icons.check) : const Text(''),
      ),
    );
  }

  void _saveLanguage(BuildContext context, String languageCode, String countryCode) async {
    await SharedPrefs.saveLanguage(languageCode, countryCode);
    Get.find<MoreController>().changeLocale(languageCode, countryCode); 
    Get.updateLocale(Locale(languageCode, countryCode));
    setState(() {
      isSelectedEnglish = languageCode == AppConstant.en;
      isSelectedKhmer = languageCode == AppConstant.km;
      isSelectedChinese = languageCode == AppConstant.zh;
    });
  }
}

// use this one can effect to the whole app......
//   void _saveLanguage(BuildContext context, String languageCode, String countryCode) async {
//   await SharedPrefs.saveLanguage(languageCode, countryCode);
//   Get.find<MoreController>().changeLocale(languageCode, countryCode); // Update locale in MoreController
//   Get.updateLocale(Locale(languageCode, countryCode));
//   setState(() {
//     isSelectedEnglish = languageCode == AppConstant.en;
//     isSelectedKhmer = languageCode == AppConstant.km;
//     isSelectedChinese = languageCode == AppConstant.zh;
//   });
// }