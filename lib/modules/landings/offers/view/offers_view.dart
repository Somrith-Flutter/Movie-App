import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/offers/controller/offers_controller.dart';
import 'package:legend_cinema/modules/landings/offers/widget/offers_items_widget.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
import 'offers_detail.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    OffersController controller = Get.find();
    controller.fetchOffers();
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: TextWidget(
            S.of(context).offer,
            size: 22,
            bold: true,
          ),
          flexibleSpace: AppConstant.appbarTheme),
      backgroundColor: Colors.black87,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return _buildDataNotAvalible(context);
        } else if (controller.offers.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          return _buildBody(context);
        }
      }),
    );
  }

  Widget _buildBody(BuildContext context) {
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
                AssetPath.cinema1,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidget(
                S.of(context).what_we_offer,
                size: 18,
                bold: true,
              ),
            ),
            _buildOffers(),
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 12, bottom: 8),
              child: TextWidget(
                S.of(context).premium_benifit,
                size: 18,
                bold: true,
              ),
            ),
            _buildPremiumBenifit(context),
            const Gap(100)
          ],
        ),
      ),
    );
  }

  Widget _buildOffers() {
    OffersController controller = Get.find();
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.offers.length,
      itemBuilder: (context, index) {
        final item = controller.offers[index];
        String cacheImage({String? img}) {
          if (AppConstant.baseIosIP == AppConstant.domainKey ){
            img = item.image!;
          }
          if (AppConstant.baseAndroidIP == AppConstant.domainKey){
            img = "${AppConstant.domainKey}/${item.image.toString()}";
          }
          return img ?? '';
        }
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  image: item.image!,
                  title: item.title!,
                ),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white70,
                  width: 1,
                ),
              ),
              child: Column( 
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: cacheImage(),
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.maxFinite,
                      placeholder: (context, url) => Container(
                        height: 250,
                        width: double.maxFinite,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 250,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AssetPath.invalidImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextWidget(
                      item.title!,
                      size: 16,
                      overflow: TextOverflow.ellipsis,
                      bold: true,
                      maxLines: 2,
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

  Widget _buildPremiumBenifit(BuildContext context) {
    List<String> titless = [
      S.of(context).offer_dis_t1,
      S.of(context).offer_dis_t2,
      S.of(context).offer_dis_t3,
    ];

    List<String> subtitless = [
      S.of(context).offer_s1,
      S.of(context).offer_s2,
      S.of(context).offer_s3,
    ];
    return Container(
      padding: const EdgeInsets.only(left: 12),
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: icons.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(0),
            child: Card(
              child: Stack(
                children: [
                  Container(
                    width: 350,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.shade800,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              titless[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              subtitless[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SizedBox(
                      height: 100,
                      width: 150,
                      child: Image.asset(icons[index]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDataNotAvalible(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 220,
          child: Image.asset(
            AssetPath.cinema1,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18, left: 12, bottom: 12),
          child: Align(
            alignment: Alignment.topLeft,
            child: TextWidget(
              S.of(context).premium_benifit,
              size: 18,
              bold: true,
            ),
          ),
        ),
        _buildPremiumBenifit(context),
      ],
    );
  }
}
