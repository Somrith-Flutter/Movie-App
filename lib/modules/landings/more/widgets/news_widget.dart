import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/landings/more/widgets/news_details_widget.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/no_data_found.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MoreController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        centerTitle: true,
        title: Text(S.of(context).news_activity),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.errorMessage.isNotEmpty) {
          return _buildDataNotAvailable();
        } else if (controller.newsAndActivities.isEmpty) {
          return const Center(
            child: Text('No data available.'),
          );
        } else {
          return SingleChildScrollView(
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
                _buildNewsWidget(),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildNewsWidget() {
    MoreController controller = Get.find();
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.newsAndActivities.length,
      itemBuilder: (context, index) {
        final item = controller.newsAndActivities[index];
        String cacheImage({String? img}){
          if (AppConstant.baseIosIP == AppConstant.domainKey ){
            img = item.imageUrl;
          }
          if (AppConstant.baseAndroidIP == AppConstant.domainKey){
            img = "${AppConstant.domainKey}/${item.imageUrl}";
            debugPrint(img);
          }
          return img ?? '';
        }
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsDetailsWidget(
                        image: cacheImage(),
                        title: item.title ?? '',
                        description: item.description ?? '',
                      ))),
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
                            imageUrl: cacheImage(),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Text('No Image'),
                            ),
                          )
                        : const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('No Image'),
                            ),
                          ),
                  ),
                  ListTile(
                    title: TextWidget(
                      item.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      bold: true,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildDataNotAvailable() {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Image.asset(
            AssetPath.news1,
            fit: BoxFit.fill,
          ),
        ),
        const Expanded(child: NoDataFound()),
      ],
    );
  }
}
