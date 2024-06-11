import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({
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
      backgroundColor: AppColor.primaryColor.withOpacity(0.5),
      appBar: AppBar(
        centerTitle: true,
        title: Text(title ?? ''),
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
                border: Border.all(color: Colors.white, style: BorderStyle.solid),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  image ?? '',
                  fit: BoxFit.fill,
                  height: 250,
                  width: double.infinity,
                ),
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
