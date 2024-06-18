import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
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
          title: const TextWidget('Purchase', size: 22, bold: true,),
          flexibleSpace: AppConstant.appbarTheme,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'History'),
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
        _buildUpcomingTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildUpcomingTab(){
    return Column(
      children: [
        const Gap(100),
        SizedBox(
          height: 300,
          width: 300,
          child: Image.asset(AssetPath.purchase, fit: BoxFit.contain,)
        ),
        const Gap(10),
        const TextWidget(
          'No Upcoming Tickets',
          size: 20,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildHistoryTab(){
    return Column(
      children: [
        const Gap(100),
        SizedBox(
          height: 300,
          width: 300,
          child: Image.asset(AssetPath.purchase, fit: BoxFit.contain,)
        ),
        const TextWidget(
          'No Ticket History',
          size: 20,
          color: Colors.grey,
        ),
      ],
    );
  }
}