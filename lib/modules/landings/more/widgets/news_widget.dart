import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/landings/more/repository/more_repository.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/movie_details_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MoreController(repository: MoreRepository()));
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        centerTitle: true,
        title: Text(S.of(context).news_activity),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: Colors.black87,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${controller.errorMessage}'));
        } else if (controller.newsAndActivities.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 220,
                    child: Image.asset(
                      AssetPath.news1,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWidget(
                      S.of(context).what_new,
                      size: 18,
                      bold: true,
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.newsAndActivities.length,
                    itemBuilder: (context, index) {
                      final item = controller.newsAndActivities[index];
                      return GestureDetector(
                        onTap: () => AppRoute().pushReplacement(
                          context,
                          MovieDetailsWidget(
                            image: item.imageUrl ?? '',
                            title: item.title ?? '',
                            description: item.description ?? '',
                          ),
                        ),
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.white70,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: item.imageUrl != null
                                      ? CachedNetworkImage(
                                          imageUrl: item.imageUrl!,
                                          fit: BoxFit.fill,
                                          height: 200,
                                        )
                                      : const SizedBox(
                                          height: 200,
                                          child: Center(
                                            child: Text('No Image'),
                                          ),
                                        ),
                                ),
                                ListTile(
                                  title: Text(
                                    item.title ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}