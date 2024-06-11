import 'package:flutter/material.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/movie_details_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
List<String> image = [
  AssetPath.news2,
  AssetPath.news3,
  AssetPath.news4,
  AssetPath.news5,
  AssetPath.news6,
  AssetPath.news7,
  AssetPath.news8
];

List<String> titles = [
  'The Successor Conserve, Create & Innovate',
  "Expirence Luxury Cinrma with Legend Cinmna's Diamond Class Ticket Pakage",
  'Include in Culinary Excellence with Legend Cinema Catering Service!',
  'Legend Cinema Indroduces the First Ever Dining Cinema Experience in Cambodia',
  'Celebrating a 12 Years of Legend Cinema: A Business Success Story in the Cambodian',
  "(COCA-COLA) Cambodia Berverage Company and Legend Cinema",
  "Legend Cinema & Smart Continue Partnership for There more years across."
];
class NewsAndActivityView extends StatelessWidget {
  const NewsAndActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidgetScreen(),
        centerTitle: true,
        title: Text(S.of(context).news_activity),
        flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromRGBO(184, 10, 10, 1), Colors.black],
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
                itemCount: image.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => AppRoute().pushReplacement(context, MovieDetailsWidget(
                        image: image[index],
                        title: titles[index],
                        description: titles[index],
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
            ]
          ),
        ),
      ),
    );
  }
}