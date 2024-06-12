import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: Text(S.of(context).language),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextWidget(S.of(context).language, size: 16,),
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
      ),
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
        ),
        title: Text(language),
        trailing: Checkbox(
          value: isSelected,
          onChanged: (bool? value) {
            showConfirmationDialog(context, languageCode, countryCode);
          },
        ),
      ),
    );
  }

  void showConfirmationDialog(BuildContext context, String languageCode, String countryCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).confirm),
          content: const Text('Are you sure to change language'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).btn_no),
            ),
            TextButton(
              onPressed: () {
                _saveLanguage(context, languageCode, countryCode);
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).btn_yes),
            ),
          ],
        );
      },
    );
  }

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
void _saveLanguage(BuildContext context, String languageCode, String countryCode) async {
  await SharedPrefs.saveLanguage(languageCode, countryCode);
  Get.find<MoreController>().changeLocale(languageCode, countryCode); // Update locale in MoreController
  Get.updateLocale(Locale(languageCode, countryCode));
  setState(() {
    isSelectedEnglish = languageCode == AppConstant.en;
    isSelectedKhmer = languageCode == AppConstant.km;
    isSelectedChinese = languageCode == AppConstant.zh;
  });
}
}