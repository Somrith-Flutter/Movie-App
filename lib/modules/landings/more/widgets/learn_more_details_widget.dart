import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class LernMoreDetailsWidget extends StatelessWidget {
  const LernMoreDetailsWidget({
    super.key,
    this.thumbnail,
    this.title,
    this.content,
  });

  final String? thumbnail;
  final String? title;
  final String? content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: const TextWidget('Benifit', size: 26, bold: true,),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      body:  Column(
        children: [
          SizedBox(
            height: 300,
            width: double.maxFinite,
            child: Image.asset(thumbnail!),
          ),
          const Gap(24),
          Align(
            alignment: Alignment.topLeft,
            child: TextWidget(title),
          ),
          const Gap(12),
          Align(
            alignment: Alignment.topLeft,
            child: TextWidget(content),
          )
        ],
      ),
    );
  }
}