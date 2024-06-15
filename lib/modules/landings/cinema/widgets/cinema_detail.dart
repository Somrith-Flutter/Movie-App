import 'package:flutter/material.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

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

  void _onTabTap(bool isTextSelected) {
    setState(() {
      isTextTapSelected = isTextSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(
          widget.title,
          size: 26,
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
      body: Column(
        children: [
          Image.asset(widget.detailImage, height: 200, fit: BoxFit.cover),
          _buildTapSelected(),
          Expanded(
            child: isTextTapSelected
                ? Column(
              children: [
                Row(
                  children: daysOfWeek.map((date) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = date;
                          });
                        },
                        child: Container(
                          height: 100,
                          margin: const EdgeInsets.all(4),
                          padding:
                          const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: selectedDay == date
                                ? Colors.blue
                                : Colors.grey[800],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              date,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    selectedDay,
                    size: 18,
                    bold: true,
                    color: Colors.blue,
                  ),
                ),
              ],
            )
                : Center(child: TextWidget("Ah bek")),
          ),
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
}
