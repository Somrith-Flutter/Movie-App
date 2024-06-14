import 'package:flutter/material.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class TermConditionWidget extends StatelessWidget {
  const TermConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(S.of(context).term_condition),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: AppColor.primaryColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    return Container();
  }
}