import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class DetailScreen extends StatelessWidget {
  final String image;
  final String title;

  const DetailScreen({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const BackWidget(),
        title: Text(title),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppColor.appbarColor,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.fill,
                height: 250, 
                width: double.infinity, 
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidget(
                title,
                bold: true,
                size: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidget(
                'Detailed information about $title goes here. This is where you can add more text, images, or any other content to describe the offer in detail.',
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
