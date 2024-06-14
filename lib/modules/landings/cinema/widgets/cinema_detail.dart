import 'package:flutter/material.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

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
          Container(
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
                TextWidget("|", size: 30),
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
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  isTextTapSelected?
                      TextWidget("hahaha"):TextWidget("Ah bek")
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
