import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/modules/landings/cinema/widgets/cinema_movie_detail.dart';
import 'package:legend_cinema/modules/landings/home/controller/home_controller.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/no_data_found.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
import 'package:intl/intl.dart';

class CinemaDetail extends StatefulWidget {
  final String detailImage;
  final String title;

  const CinemaDetail(
      {super.key, required this.detailImage, required this.title});

  @override
  State<CinemaDetail> createState() => _CinemaDetailState();
}

class _CinemaDetailState extends State<CinemaDetail> {
  bool isTextTapSelected = true;
  String selectedDay = '';
  final dateInfo = DateInfo();
  final _movie = Get.find<HomeController>();

  void _onTabTap(bool isTextSelected) {
    setState(() {
      isTextTapSelected = isTextSelected;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), (){
      _movie.fetchMoiveController(location: widget.title.toString().toLowerCase());
    });
    selectedDay = dateInfo.dates.first;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (logic) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: const BackWidget(),
            title: TextWidget(
              widget.title,
              size: 20.0,
              bold: true,
              overflow: TextOverflow.ellipsis,
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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Image.asset(widget.detailImage, height: 200, fit: BoxFit.cover),
                _buildTapSelected(),
                isTextTapSelected ? _buildNowShowing() : _buildDetail(),
                _buildMoiveShow()
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildTapSelected() {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              _onTabTap(true);
            },
            child: TextWidget(
              "Now Showing",
              bold: true,
              color: isTextTapSelected ? Colors.white : Colors.grey,
            ),
          ),
          const TextWidget("|", size: 30),
          GestureDetector(
            onTap: () {
              _onTabTap(false);
            },
            child: TextWidget(
              "Detail",
              bold: true,
              color: isTextTapSelected ? Colors.grey : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNowShowing() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(dateInfo.dates.length, (index) {
              final date = dateInfo.dates[index];
              final day = dateInfo.dayNames[index];
              final month = dateInfo.months[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDay = date;
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 80,
                        width: 70,
                        decoration: BoxDecoration(
                          border: selectedDay == date
                              ? Border.all(color: Colors.red, width: 2)
                              : Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 20,
                        child: TextWidget(
                          day,
                          size: 12,
                        ),
                      ),
                      Positioned(
                        top: 25,
                        left: 20,
                        child: TextWidget(
                          date,
                          bold: true,
                          size: 22,
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 25,
                        child: TextWidget(
                          month,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 30),
          const TextWidget(
            "Now Showing",
            size: 22,
            bold: true,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildMoiveShow() {
    if(_movie.response == BaseStatusEnum.inprogress){
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }

    if(_movie.response == BaseStatusEnum.failure){
      return const Center(
        child: NoDataFound(),
      );
    }

    return GestureDetector(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.5,
        ),
        itemCount: _movie.moive.length,
        itemBuilder: (BuildContext context, int index) {debugPrint("${_movie.moive.length}");
          final data = _movie.moive[index];
          return GestureDetector(
            onTap: () {
              AppRoute.route.push(
                  context,
                  CinemaMovieDetail(data: [data], location: data.location));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: "${AppConstant.domainKey}/${data.imageUrl.toString()}",
                      fit: BoxFit.cover,
                      height: 300,
                      errorWidget: (context, url, error) => const Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    )
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      TextWidget(
                        data.release,
                        bold: true,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: TextWidget(
                            data.classification,
                            color: Colors.black,
                            bold: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextWidget(
                    data.title,
                    color: Colors.white,
                    size: 16,
                    bold: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetail() {
    return const Center(child: TextWidget("Ah bek"));
  }

  List<String> get daysOfWeek {
    final now = DateTime.now();
    final dateFormat = DateFormat('EEE, MMM d'); // Format: Day, Month Day
    final days = List.generate(4, (i) => now.add(Duration(days: i)));

    return days.map((date) {
      if (date.isAtSameMomentAs(now)) {
        return 'Today, ${DateFormat('MMM d').format(date)}'; // Format for Today
      } else {
        return dateFormat.format(date);
      }
    }).toList();
  }

  final List<Map<String, String>> cinema = [
    {
      "image": AssetPath.boyKill,
      "title": "Boy Kills World",
      "genre": "Action",
      "duration": "1h 50mins",
      "release": "14 Jun 2024",
      "classification": "R18",
    },
    {
      "image": AssetPath.darkMother,
      "title": "Dark Mother (Extended Version),The",
      "genre": "Horror",
      "duration": "1h 50mins",
      "release": "06 June 2024",
      "classification": "NC15",
    },
    {
      "image": AssetPath.motherGhost,
      "title": "Dear Mother Ghost",
      "genre": "Horror",
      "duration": "1h 50mins",
      "release": "13 June 2024",
      "classification": "NC15",
    },
    {
      "image": AssetPath.police,
      "title": "Formed Police Unit",
      "genre": "Action",
      "duration": "1h 40mins",
      "release": "14 June 2024",
      "classification": "TBC",
    },
    {
      "image": AssetPath.saga,
      "title": "Furiosa: A Mad Max Saga",
      "genre": "Action",
      "duration": "2h 29mins",
      "release": "23 May 2024",
      "classification": "R18",
    },
    {
      "image": AssetPath.inside,
      "title": "Inside Out 2",
      "genre": "Animation",
      "duration": "1h 36mins",
      "release": "13 June 2024",
      "classification": "G",
    },
    {
      "image": AssetPath.roundUp,
      "title": "Roundub : Punishment, The",
      "genre": "Action",
      "duration": "1h 49mins",
      "release": "14 May 2024",
      "classification": "R18",
    },
    {
      "image": AssetPath.sinden,
      "title": "Sinden Gaib",
      "genre": "Horror",
      "duration": "1h 35mins",
      "release": "07 June 2024",
      "classification": "R18",
    },
    {
      "image": AssetPath.under,
      "title": "Under Parallel Skies",
      "genre": "romance",
      "duration": "1h 50mins",
      "release": "12 June 2024",
      "classification": "G",
    },
    {
      "image": AssetPath.watcher,
      "title": "Watcher, The",
      "genre": "Horror",
      "duration": "1h 41mins",
      "release": "06 June 2024",
      "classification": "NC15",
    },
  ];
}

class DateInfo {
  final now = DateTime.now();

  List<String> get daysOfWeek {
    final days = List.generate(4, (i) => now.add(Duration(days: i)));
    return days.map((date) {
      if (date.isAtSameMomentAs(now)) {
        return 'Today, ${DateFormat('MMM d').format(date)}';
      } else {
        return DateFormat('EEE, MMM d').format(date);
      }
    }).toList();
  }

  List<String> get dayNames {
    final days = List.generate(4, (i) => now.add(Duration(days: i)));
    return days.map((date) {
      if (date.day == now.day &&
          date.month == now.month &&
          date.year == now.year) {
        return 'Today';
      } else {
        return DateFormat('EEE').format(date);
      }
    }).toList();
  }

  List<String> get months {
    final days = List.generate(4, (i) => now.add(Duration(days: i)));
    return days.map((date) => DateFormat('MMM').format(date)).toList();
  }

  List<String> get dates {
    final days = List.generate(4, (i) => now.add(Duration(days: i)));
    return days.map((date) => DateFormat('d').format(date)).toList();
  }
}
