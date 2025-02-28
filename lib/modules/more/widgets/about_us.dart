import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/modules/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/more/repository/more_repository.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/no_data_found.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
class AboutUsWidget extends StatefulWidget {
  const AboutUsWidget({super.key});

  @override
  State<AboutUsWidget> createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  final MoreController controller = Get.put(MoreController(repository: MoreRepository()));

  @override
  void initState() {
    super.initState();
    controller.fetchAboutus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(S.of(context).about_us, size: 22, bold: true,),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator()
          );
        } else if (controller.errorMessage.isNotEmpty) {
          return const NoDataFound();
        } else if (controller.aboutus.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          final about = controller.aboutus.first;
          String cacheImage({String? img}){
            if (AppConstant.baseIosIP == AppConstant.domainKey ){
              img = about.image;
            }
            if (AppConstant.baseAndroidIP == AppConstant.domainKey){
              img = "${AppConstant.domainKey}/${about.image}";
              debugPrint(img);
            }
            return img ?? '';
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 220,
                  width: double.maxFinite,
                  child: CachedNetworkImage(
                    imageUrl: cacheImage(),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                const Gap(12),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextWidget(
                    about.title ?? '',
                    size: 24,
                    bold: true,
                  ),
                ),
                if (about.subtitle != null && about.subtitle!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0,left: 12, top: 8),
                    child: TextWidget(
                      about.subtitle!,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12),
                  child: TextWidget(
                    '    ${about.description}',
                    size: 16,
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}