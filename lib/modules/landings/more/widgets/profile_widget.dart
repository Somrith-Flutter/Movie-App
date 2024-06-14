import 'package:flutter/material.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class ProfileWidget  extends StatelessWidget {
  const ProfileWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: const TextWidget('Profile'),
        actions: [
          TextButton(
            onPressed: (){}, 
            child: const TextWidget('Save', bold: true,)
          )
        ],
      ),
      backgroundColor: AppColor.primaryColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    return const Column();
  }
}