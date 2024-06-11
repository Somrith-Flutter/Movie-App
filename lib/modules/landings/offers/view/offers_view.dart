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
  AssetPath.cinemaCard1,
  AssetPath.cinema8,
];

List<String> titles = [
  'Donate 0.50 to child for every purchase of a Hope Combo',
  'My Boo is now playing at Legend Cinema.',
  'Special Combo Set',
  'Happy Anniversary 13Year',
  'Bad Boys: Ride or Die',
  'Special price for students and senior citizen. Applicable on week days, weekends and public Holiday',
  'Celebrate Coca-Cola Day with us!',
];

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
              SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: titless.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Stack(
                          children: [
                            Container(
                              width: 310,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.red.shade900,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      titless[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      subtitless[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -10,
                              right: 0,
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.asset(AssetPath.cinema1)
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
