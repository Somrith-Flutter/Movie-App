import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/no_image_avalible.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class NewsDetailsWidget extends StatelessWidget {
  const NewsDetailsWidget({
    super.key,
    this.image,
    this.title,
    this.description,
  });

  final String? image;
  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        leading: const BackWidget(),
        centerTitle: true,
        title: TextWidget(title ?? '', bold: true,),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppColor.appbarColor
            )
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.3), style: BorderStyle.solid),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: image!,
                  fit: BoxFit.cover,
                  height: 250,
                  width: 400,
                  errorWidget: (context, url, error) => const NoImageAvailable(),
                )
              ),
            ),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  TextWidget(
                    title ?? '',
                    size: 18,
                  ),
                  const Gap(8),
                  TextWidget(
                    title ?? '',
                    size: 14,
                    bold: true,
                  ),
                  const Gap(8),
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                      description ?? '',
                      size: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
