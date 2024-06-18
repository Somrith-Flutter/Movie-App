import 'package:flutter/material.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/cinema/widgets/cinema_detail.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class CinemaView extends StatelessWidget {
  CinemaView({super.key});

  final List<Map<String, dynamic>> cinema = [
    {
      "main_image": AssetPath.megaMall,
      "detail_image": AssetPath.megaMallDetail,
      "title": "Legend Cinema 271 Mega Mall",
      "subtitle": "3rd Floor, Chip Mong Mega Mall,",
      "map_image": AssetPath.mapChipMong,
      "opening_hour": "09:30 - 22:30",
      "number_hall": "7",
      "address": "3rd Floor, Chip Mong Mega Mall,St271, Phum Prek Ta Nu, Sangkat Chak Angrea Lue, Khan Mean Chey",
    },
    {
      "main_image": AssetPath.sihanouk,
      "detail_image": AssetPath.sihanoukDetail,
      "title": "Legend Cinema Sihanoukville",
      "subtitle": "PGB-5-021, 4th Floor of prince",
      "map_image": AssetPath.mapSihanouk,
      "opening_hour": "09:30 - 22:30",
      "number_hall": "4",
      "address": "PGB-5-021, 4th Floor of prince , PGB-5-021, 4th Floor of Prince,Sihanoukville",
    },
    {
      "main_image": AssetPath.eden,
      "detail_image": AssetPath.edenDetail,
      "title": "Legend Eden Garden",
      "subtitle": "City Center Boulevard, sangkat Srah chak, Khan Daun Penh,",
      "map_image": AssetPath.mapEden,
      "opening_hour": "09:30 - 22:30",
      "number_hall": "8",
      "address": "City Center Boulevard, sangkat Srah chak, Khan Daun Penh,",
    },
    {
      "main_image": AssetPath.kMall,
      "detail_image": AssetPath.kMallDetail,
      "title": "Legend K Mall",
      "subtitle": "2nd Floor, K Mall",
      "map_image": AssetPath.mapKMall,
      "opening_hour": "09:30 - 22:30",
      "number_hall": "5",
      "address": "2nd Floor, K Mall, Veng Sreng Blvd",
    },
    {
      "main_image": AssetPath.meanchey,
      "detail_image": AssetPath.meancheyDetail,
      "title": "Legend Meanchey",
      "subtitle": "3rd Floor of New Steung Meanchey market",
      "map_image": AssetPath.mapMeanChey,
      "opening_hour": "09:30 - 22:30",
      "number_hall": "5",
      "address": "3rd Floor of New Steung Meanchey market,Veng Sreng Blvd, Sangkat Steung Mean Chey, Khan Mean Chey",
    },
    {
      "main_image": AssetPath.midTown,
      "detail_image": AssetPath.midTownDetail,
      "title": "Legend Midtown Mall",
      "subtitle": "1st Floor Midtown Mall",
      "map_image": AssetPath.mapMidtown,
      "opening_hour": "09:30 - 22:30",
      "number_hall": "4",
      "address": "1st Floor Midtown Mall, St.2004 Corner 13B",
    },
    {
      "main_image": AssetPath.noroMall,
      "detail_image": AssetPath.noroMallDetail,
      "title": "Legend Noro Mall",
      "subtitle": "5th Floor, Chip Mong Nora Mall",
      "map_image": AssetPath.mapNoro,
      "opening_hour": "09:30 - 22:30",
      "number_hall": "3",
      "address": "5th Floor, Chip Mong Nora Mall, Preah Norodom Blvd (41)",
    },
    {
      "main_image": AssetPath.olympia,
      "detail_image": AssetPath.olympiaDetail,
      "title": "Legend Olympia",
      "subtitle": "6th Floor, The Olympia Mall",
      "map_image": AssetPath.mapOlympia,
      "opening_hour": "09:30 - 22:30",
      "number_hall": "7",
      "address": "6th Floor, The Olympia Mall, Monireth Blvd(217), Sangkat Veal Vong Khan 7 Makara",
    },
    {
      "main_image": AssetPath.premium,
      "detail_image": AssetPath.premiumDetail,
      "title": "Legend Premium Exchange Square",
      "subtitle": "Street 106, Corner of Street 61",
      "map_image": AssetPath.mapPremium,
      "opening_hour": "09:30 - 22:30",
      "number_hall": "4",
      "address": "Street 106, Corner of Street 61, Sangkat Wat Phnom",
    },
    {
      "main_image": AssetPath.sensok,
      "detail_image": AssetPath.sensokDetail,
      "title": "Legend SenSok",
      "subtitle": "4th Floor, Chip Mong SenSok Mall",

      "map_image": AssetPath.mapSenSok,
      "opening_hour": "09:30 - 22:30",
      "number_hall": "5",
      "address": "4th Floor, Chip Mong SenSok Mall, Oknha Mong Reththey street, Khan Sen Sok",
    },
    {
      "main_image": AssetPath.siemreap,
      "detail_image": AssetPath.siemreapDetail,
      "title": "Legend Siem Reap",
      "subtitle": "Level 3, The Heritage Walk, Corner Street 61, SiemReap",
      "map_image": AssetPath.mapSiemReap,
      "opening_hour": "09:30 - 22:30",
      "number_hall": "5",
      "address": "Level 3, The Heritage Walk, Corner of National Road 6 and Oum Chhay Street, Svay DongKoum Commune Krong Siem Reab",
    },
    {
      "main_image": AssetPath.toulkork,
      "detail_image": AssetPath.megaMallDetail,
      "title": "Legend Toul Kork",
      "subtitle": "TK Avenue Mall, Street 315",
      "map_image": AssetPath.mapToulKork,
      "opening_hour": "09:30 - 22:30",
      "number_hall": "3",
      "address": "TK Avenue Mall, Street 315, Snagkat Beongkok 1, Khan Toul Kork",
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
                            detailImage: item["detail_image"],
                            title: item["title"],
                            mapImages: item['map_image'],
                            address: item['address'],
                            numberHall: item['number_hall'],
                            openingHour: item['opening_hour'],
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
