import 'package:flutter/material.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class CinemaView extends StatelessWidget {
  CinemaView({super.key});

  final List<Map<String, String>> cinema = [
    {
      "image": AssetPath.cinema3, // Replace with your actual asset path
      "title": "Legend Cinema 271 Mega Mall",
      "subtitle": "3rd Floor, Chip Mong Mega Mall,",
    },
    {
      "image": AssetPath.cinema2, // Replace with your actual asset path
      "title": "Legend Cinema Sihanoukville",
      "subtitle": "PGB-5-021, 4th Floor of prince",
    },
    {
      "image": AssetPath.cinema1, // Replace with your actual asset path
      "title": "Legend Eden Garden",
      "subtitle": "City Center Boulevard, sangkat Sraschork, PhnomPenh City",
    },
    {
      "image": AssetPath.cinema3, // Replace with your actual asset path
      "title": "Movie 1",
      "subtitle": "Subtitle 1",
    },
    {
      "image": AssetPath.cinema2, // Replace with your actual asset path
      "title": "Movie 2",
      "subtitle": "Subtitle 2",
    },
    {
      "image": AssetPath.cinema1, // Replace with your actual asset path
      "title": "Movie 3",
      "subtitle": "Subtitle 3",
    },
    {
      "image": AssetPath.cinema3, // Replace with your actual asset path
      "title": "Movie 1",
      "subtitle": "Subtitle 1",
    },
    {
      "image": AssetPath.cinema2, // Replace with your actual asset path
      "title": "Movie 2",
      "subtitle": "Subtitle 2",
    },
    {
      "image": AssetPath.cinema1, // Replace with your actual asset path
      "title": "Movie 3",
      "subtitle": "Subtitle 3",
    },
    {
      "image": AssetPath.cinema3, // Replace with your actual asset path
      "title": "Movie 1",
      "subtitle": "Subtitle 1",
    },
    {
      "image": AssetPath.cinema2, // Replace with your actual asset path
      "title": "Movie 2",
      "subtitle": "Subtitle 2",
    },
    {
      "image": AssetPath.cinema1, // Replace with your actual asset path
      "title": "Movie 3",
      "subtitle": "Subtitle 3",
    },
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: false,
        title: const TextWidget(
          'Cinema',
          size: 24,
        ),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: cinema.length,
          itemBuilder: (context, index) {
            final item = cinema[index];
            return Container(
              margin: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      item["image"]!,
                      fit: BoxFit.cover,
                      height: 280, // Adjust height as per your requirement
                    ),
                  ),
                  ListTile(
                    title: TextWidget(
                      item["title"]!,
                      size: 20,
                      bold: true,
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
            );
          },
        ),
      ),
    );
  }
}
