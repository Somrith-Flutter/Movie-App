import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/landings/more/repository/more_repository.dart';
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
  final MoreController controller =
      Get.put(MoreController(repository: MoreRepository()));

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
        title: TextWidget(
          S.of(context).about_us,
          size: 22,
          bold: true,
        ),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return const NoDataFound();
        } else if (controller.aboutus.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          final about = controller.aboutus.first;
          String cacheImage({String? img}) {
            if (AppConstant.baseIosIP == AppConstant.domainKey) {
              img = about.image;
            }
            if (AppConstant.baseAndroidIP == AppConstant.domainKey) {
              img = "${AppConstant.domainKey}/${about.image}";
              debugPrint("about us $img");
            }
            return img ?? '';
          }

          return ListView.builder(
            itemCount: controller.aboutus.length,
            itemBuilder: (context, index) {
              final us = controller.aboutus[index];
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 175,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: CachedNetworkImage(
                              imageUrl: "${AppConstant.domainKey}/${us.image}",
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        const Gap(12),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                about.title ?? '',
                                size: 22,
                                bold: true,
                              ),
                              if (us.subtitle != null &&
                                  us.subtitle!.isNotEmpty)
                                TextWidget(
                                  about.subtitle!,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              TextWidget(
                                '${us.description}',
                                size: 16,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
