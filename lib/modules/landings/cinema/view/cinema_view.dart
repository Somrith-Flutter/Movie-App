import 'package:flutter/material.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/offers/view/offers_detail.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
List<String> image = [
  AssetPath.cinema2,
  AssetPath.cinema6,
  AssetPath.cinema4,
  AssetPath.cinema5,
  AssetPath.cinema7,
];

List<String> imageCard = [
  AssetPath.cinemaCard1,
  AssetPath.cinema6,
  AssetPath.cinema7,
];

List<String> titles = [
  'Special Offer 1',
  'Special Offer 2',
  'Special Offer 3',
  'Special Offer 4',
  'Special Offer 5',
];
class CinemaView extends StatelessWidget {
  const CinemaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const TextWidget('Cinema',size: 24,),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppColor.appbarColor,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: image.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          image: image[index],
                          title: titles[index],
                        ),
                      ),
                    );
                  },
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
                            child: Image.asset(
                              image[index],
                              fit: BoxFit.fill,
                              height: 200,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              titles[index],
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
}