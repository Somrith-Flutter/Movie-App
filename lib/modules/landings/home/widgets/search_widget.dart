import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

List<String> img = [
  'assets/images/img.png',
];

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: const TextWidget(
          'Search',
          size: 22,
          bold: true,
        ),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: Colors.black,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search cinema...",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
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
          const SizedBox(height: 180),
          _showImages(),
        ],
      ),
    );
  }

  Widget _showImages() {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      height: 200, // Example height
      color: Colors.grey, // Placeholder color
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: img.isNotEmpty
                ? Image.asset(img[0])
                : const Text(
              'No images to display',
              style: TextStyle(color: Colors.white),
            ),
          ),
         const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(height: 30),
          ),
          const Text(
            "hello",
            style: TextStyle(color: Colors.white,
            fontSize: 24),
          ),
        ],
      ),
    );
  }}
