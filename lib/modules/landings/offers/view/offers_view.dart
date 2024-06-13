import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/offers/controller/offers_controller.dart';
import 'package:legend_cinema/modules/landings/offers/repository/offers_repository.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
import 'offers_detail.dart';

List<String> titless = [
  'Discount 10% Concession',
  'Discount 10% Ticket',
  'Buy 1 get 1 Every Tuesday',
];

List<String> subtitless = [
  '10% discount on concession',
  '10% discount on ticket',
  'Buy one get one tickets free!',
];

List<String> icons = [
  AssetPath.offer3,
  AssetPath.offer2,
  AssetPath.offer1,
];
final controller = Get.put(OffersController(repository: OffersRepository()));
class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchOffers();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(S.of(context).offer),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black87,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator()
          );
        } else if (controller.errorMessage.isNotEmpty) {
          return const Center(
            child: Text('Something when wrong!, Please check or ensure your connection!')
          );
        } else if (controller.offers.isEmpty) {
          return const Center(
            child: Text('No data available.')
          );
        } else {
          return _buildBody(context);
        }
      }),
    );
  }

  Widget _buildBody(BuildContext context){
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
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.offers.length,
              itemBuilder: (context, index) {
                final item = controller.offers[index];
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
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: CachedNetworkImage(
                              imageUrl: item.image!,
                              fit: BoxFit.fill,
                              height: 250,
                              width: 400,
                            ),
                          ),
                          ListTile(
                            title: TextWidget(
                              item.title!,
                              size: 20,
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidget(
                S.of(context).premium_benifit,
                size: 18,
                bold: true,
              ),
            ),
            _buildPremiumBenifit(),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumBenifit(){
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: icons.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
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
}