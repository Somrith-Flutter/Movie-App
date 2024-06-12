import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(S.of(context).notification),
        centerTitle: true,
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
      body: _buildBody(),
    );
  }
  
  Widget _buildBody(){
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: SwitchListTile.adaptive(
        title: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Icons.notifications,
                size: 22,
                color: AppColor.chart6,
              ),
            ),
            const Gap(8),
            TextWidget(S.of(context).notification),
          ],
        ),
        value: isOpen,
        onChanged: (con){
          setState(() {
            isOpen =! isOpen;
          });
        },
      ),
    );
  }
}