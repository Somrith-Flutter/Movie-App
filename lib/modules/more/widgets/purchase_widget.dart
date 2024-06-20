import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class PurchaseWidget extends StatelessWidget {
  const PurchaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackWidget(),
          title:  TextWidget(S.of(context).purchase, size: 22, bold: true,),
          flexibleSpace: AppConstant.appbarTheme,
          bottom: TabBar(
            tabs: [
              Tab(text: S.of(context).upcoming),
              Tab(text: S.of(context).history),
            ],
            indicatorColor: Colors.red,
            unselectedLabelColor: Colors.white,
            labelColor: Colors.red,
          ),
        ),
        backgroundColor: AppColor.primaryColor,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context){
    return TabBarView(
      children: [
        _buildUpcomingTab(context),
        _buildHistoryTab(context),
      ],
    );
  }

  Widget _buildUpcomingTab(BuildContext context){
    return Column(
      children: [
        const Gap(100),
        SizedBox(
          height: 300,
          width: 300,
          child: Image.asset(AssetPath.purchase, fit: BoxFit.contain,)
        ),
        const Gap(10),
        TextWidget(
          S.of(context).no_upcoming_ticket,
          size: 20,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildHistoryTab(BuildContext context){
    return Column(
      children: [
        const Gap(100),
        SizedBox(
          height: 300,
          width: 300,
          child: Image.asset(AssetPath.purchase, fit: BoxFit.contain,)
        ),
        TextWidget(
          S.of(context).no_ticket_history,
          size: 20,
          color: Colors.grey,
        ),
      ],
    );
  }
}