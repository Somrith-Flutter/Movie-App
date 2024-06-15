import 'package:flutter/material.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
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

  void _onTabTap(bool isTextSelected) {
    setState(() {
      isTextTapSelected = isTextSelected;
    });
  }
  @override
  void initState() {
    super.initState();
    selectedDay = dateInfo.dates.first;
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Image.asset(widget.detailImage, height: 200, fit: BoxFit.cover),
          _buildTapSelected(),
          isTextTapSelected ? _buildNowShowing() : _buildDetail(),
        ],
      ),
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
                        child: TextWidget(day, size: 12,),
                      ),
                      Positioned(
                        top: 25,
                        left: 20,
                        child: TextWidget(date, bold: true, size: 22,),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 25,
                        child: TextWidget(month, size: 12,),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 30),
          const TextWidget("Now Showing",size: 22,bold: true,),
          const SizedBox(height: 30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.5,
            ),
            itemCount: cinema.length,
            itemBuilder: (BuildContext context, int index) {
              final data = cinema[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        data["image"]!,
                        fit: BoxFit.cover,
                        height: 300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        TextWidget(
                          data['date'],
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
                              data['type'],
                              color: Colors.black,
                              bold: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextWidget(
                      data['title'],
                      color: Colors.white,
                      size: 16,
                      bold: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
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
      "date": "14 Jun, 2024",
      "type": "R18",
    },
    {
      "image": AssetPath.darkMother,
      "title": "Dark Mother (Extended Version),The",
      "date": "06 Jun, 2024",
      "type": "NC15",
    },
    {
      "image": AssetPath.motherGhost,
      "title": "Dear Mother Ghost",
      "date": "13 Jun, 2024",
      "type": "NC15",
    },
    {
      "image": AssetPath.police,
      "title": "Formed Police Unit",
      "date": "14 Jun, 2024",
      "type": "TBC",
    },
    {
      "image": AssetPath.saga,
      "title": "Furiosa: A Mad Max Saga",
      "date": "23 May, 2024",
      "type": "R18",
    },
    {
      "image": AssetPath.inside,
      "title": "Inside Out 2",
      "date": "13 Jun, 2024",
      "type": "G",
    },
    {
      "image": AssetPath.roundUp,
      "title": "Roundub : Punishment, The",
      "date": "14 May, 2024",
      "type": "R18",
    },
    {
      "image": AssetPath.sinden,
      "title": "Sinden Gaib",
      "date": "07 Jun, 2024",
      "type": "R18",
    },
    {
      "image": AssetPath.under,
      "title": "Under Parallel Skies",
      "date": "12 Jun, 2024",
      "type": "G",
    },
    {
      "image": AssetPath.watcher,
      "title": "Watcher, The",
      "date": "06 Jun, 2024",
      "type": "NC15",
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
      if (date.day == now.day && date.month == now.month && date.year == now.year) {
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
