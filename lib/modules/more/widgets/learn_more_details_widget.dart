import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
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
        title: TextWidget(S.of(context).benifit, size: 22, bold: true,),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: AppColor.primaryColor,
      body:  Column(
        children: [
          SizedBox(
            height: 300,
            width: double.maxFinite,
            child: Image.asset(thumbnail!, fit: BoxFit.cover,),
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children:[
                Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(content, bold: true, size: 20,),
                ),
                const Gap(16),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(content, color: Colors.white.withOpacity(0.8),),
                )
              ]
            ),
          )
        ],
      ),
    );
  }
}