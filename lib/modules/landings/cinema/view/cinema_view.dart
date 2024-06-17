import 'package:flutter/material.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/cinema/widgets/cinema_detail.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class CinemaView extends StatelessWidget {
  CinemaView({super.key});

  final List<Map<String, String>> cinema = [
    {
      "main_image": AssetPath.megaMall,
      "detail_image": AssetPath.megaMallDetail,
      "title": "Legend Cinema 271 Mega Mall",
      "subtitle": "3rd Floor, Chip Mong Mega Mall,",
    },
    {
      "main_image": AssetPath.sihanouk,
      "detail_image": AssetPath.sihanoukDetail,
      "title": "Legend Cinema Sihanoukville",
      "subtitle": "PGB-5-021, 4th Floor of prince",
    },
    {
      "main_image": AssetPath.eden,
      "detail_image": AssetPath.edenDetail,
      "title": "Legend Eden Garden",
      "subtitle": "City Center Boulevard, sangkat Sraschork, PhnomPenh City",
    },
    {
      "main_image": AssetPath.kMall,
      "detail_image": AssetPath.kMallDetail,
      "title": "Legend K Mall",
      "subtitle": "2nd Floor, K Mall",
    },
    {
      "main_image": AssetPath.meanchey,
      "detail_image": AssetPath.meancheyDetail,
      "title": "Legend Meanchey",
      "subtitle": "3rd Floor of New Steung Meanchey New",
    },
    {
      "main_image": AssetPath.midTown,
      "detail_image": AssetPath.midTownDetail,
      "title": "Legend Midtown Mall",
      "subtitle": "1st Floor Midtown Mall",
    },
    {
      "main_image": AssetPath.noroMall,
      "detail_image": AssetPath.noroMallDetail,
      "title": "Legend Noro Mall",
      "subtitle": "5th Floor, Chip Mong Nora Mall",
    },
    {
      "main_image": AssetPath.olympia,
      "detail_image": AssetPath.olympiaDetail,
      "title": "Legend Olympia",
      "subtitle": "6th Floor, The Olympia Mall",
    },
    {
      "main_image": AssetPath.premium,
      "detail_image": AssetPath.premiumDetail,
      "title": "Legend Premium Exchange Square",
      "subtitle": "Street 106, Corner of Street 61",
    },
    {
      "main_image": AssetPath.sensok,
      "detail_image": AssetPath.sensokDetail,
      "title": "Legend SenSok",
      "subtitle": "4th Floor, Chip Mong SenSok Mall",
    },
    {
      "main_image": AssetPath.siemreap,
      "detail_image": AssetPath.siemreapDetail,
      "title": "Legend Siem Reap",
      "subtitle": "Level 3, The Heritage Walk, Corner Street 61, SiemReap",
    },
    {
      "main_image": AssetPath.toulkork,
      "detail_image": AssetPath.megaMallDetail,
      "title": "Legend Toul Kork",
      "subtitle": "TK Avenue Mall, Street 315",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const TextWidget(
            'Cinema',
            size: 20.0,
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColor.appbarColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon:
                        Icon(Icons.search, color: Colors.white.withOpacity(0.8)),
                    hintText: "Search cinema...",
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.8)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Colors.white70.withOpacity(0.1),
                  ),
                  style: TextStyle(color: Colors.white.withOpacity(0.8)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: cinema.length,
                  itemBuilder: (context, index) {
                    final item = cinema[index];
                    return GestureDetector(
                      onTap: () {
                        AppRoute.route.push(
                          context,
                          CinemaDetail(
                            detailImage: item["detail_image"]!,
                            title: item["title"]!,
                          ));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.white70,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.asset(
                                item["main_image"]!,
                                fit: BoxFit.cover,
                                height:
                                    250, // Adjust height as per your requirement
                              ),
                            ),
                            ListTile(
                              title: TextWidget(
                                item["title"]!,
                                size: 18.0,
                                bold: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: TextWidget(
                                      item["subtitle"]!,
                                      size: 16,
                                      bold: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
