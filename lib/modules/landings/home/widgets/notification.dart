import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackWidget(),
          title: const TextWidget(
            'Notification',
            size: 22,
            bold: true,
          ),
          flexibleSpace: AppConstant.appbarTheme,
           bottom: TabBar(
            tabs: [
              Tab(text: '${const TextWidget('Announcement')}'),
              Tab(text: '${const TextWidget('Orders')}'),
            ],
            indicatorColor: Colors.red,
            unselectedLabelColor: Colors.white,
            labelColor: Colors.red,
          ),
        ),
        backgroundColor: Colors.black,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody(){
    return TabBarView(
      children: [
        _buildAnnouncemnetTab(),
        _buildOrdersTab(),
      ],
    );
  }

   Widget _buildAnnouncemnetTab(){
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
          'Login Order to see notification',
          size: 20,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildOrdersTab(){
    return Column(
      children: [
        const Gap(100),
        SizedBox(
          height: 300,
          width: 300,
          child: Image.asset(AssetPath.purchase, fit: BoxFit.contain,)
        ),
        const TextWidget(
          'Login Order to see notification',
          size: 20,
          color: Colors.grey,
        ),
      ],
    );
  }
}