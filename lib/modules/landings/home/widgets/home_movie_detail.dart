import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class HomeMovieDetail extends StatefulWidget {
  const HomeMovieDetail(
      {super.key,
      required this.imageMovie,
      required this.titleMovie,
      required this.genre,
      required this.duration,
      required this.releaseDate,
      required this.classification});

  final String imageMovie;
  final String titleMovie;
  final String genre;
  final String duration;
  final String releaseDate;
  final String classification;

  @override
  State<HomeMovieDetail> createState() => _HomeMovieDetailState();
}

class _HomeMovieDetailState extends State<HomeMovieDetail> {
  final dateInfo = DateInfo();
  String selectedDay = '';

  @override
  void initState() {
    super.initState();
    selectedDay = dateInfo.dates.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  widget.imageMovie,
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
                  child: Positioned(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BackWidget(),
                      Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.5)),
                          child: const Icon(Icons.ios_share_outlined))
                    ],
                  )),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    widget.titleMovie,
                    size: 20,
                    bold: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const TextWidget(
                    "2D",
                    size: 26,
                    bold: true,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _builderRow(
                      icon: Icons.folder_shared_rounded,
                      text: "Genre: ",
                      subText: widget.genre),
                  const SizedBox(
                    height: 10,
                  ),
                  _builderRow(
                      icon: Icons.access_time_filled,
                      text: "Duration: ",
                      subText: widget.duration),
                  const SizedBox(
                    height: 10,
                  ),
                  _builderRow(
                      icon: Icons.date_range,
                      text: "Release: ",
                      subText: widget.releaseDate),
                  const SizedBox(
                    height: 10,
                  ),
                  _builderRow(
                      icon: Icons.visibility_off,
                      text: "Classification: ",
                      subText: widget.classification)
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                color: Colors.white.withOpacity(0.5),
                height: 3,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextWidget(
                "Description about the Movie",
                size: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                _buildBottomSheet(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Colors.white.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      "Legend Eden Garden",
                      size: 18,
                      bold: true,
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}

Widget _builderRow(
    {required IconData icon, required String text, required String subText}) {
  return Row(children: [
    Icon(
      icon,
      color: Colors.red,
    ),
    const SizedBox(
      width: 10,
    ),
    TextWidget(text, bold: true, color: Colors.grey),
    TextWidget(
      subText,
      bold: true,
    )
  ]);
}

Future _buildBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 500,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    "Cinema",
                    size: 19,
                    bold: true,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white.withOpacity(0.3), width: 2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Divider(
                color: Colors.white.withOpacity(0.3),
                height: 2,
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                itemCount: cinemaList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.red),
                            const SizedBox(width: 8),
                            TextWidget(cinemaList[index]["title"] ?? "",
                                size: 16, bold: true),
                          ],
                        ),
                        Divider(
                            color: Colors.white.withOpacity(0.3), height: 0.5),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

List<Map<String, String>> cinemaList = [
  {"title": "Legend Eden Garden"},
  {"title": "Legend Toul Kork"},
  {"title": "Legend Premium Exchange Square"},
  {"title": "Legend Olympia"},
  {"title": "Legend SenSok"},
  {"title": "Legend Noro Mall"},
  {"title": "Legend Midtown Mall"},
  {"title": "Legend Meanchey"},
  {"title": "Legend Cinema 271 Mega Mall"},
  {"title": "Legend K Mall"},
  {"title": "Legend Cinema Sihanoukville"},
  {"title": "Legend Siem Reap"},
];

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
