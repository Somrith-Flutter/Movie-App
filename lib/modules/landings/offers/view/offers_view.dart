import 'package:flutter/material.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
import 'offers_detail.dart';

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

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
                itemCount: image.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            imagePath: image[index],
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  S.of(context).premium_benifit,
                  size: 18,
                  bold: true,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        imagePath: imageCard[0],
                        title: S.of(context).premium_benifit,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageCard.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Card(
                            child: SizedBox(
                              width: 280,
                              child: Image.asset(
                                imageCard[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
