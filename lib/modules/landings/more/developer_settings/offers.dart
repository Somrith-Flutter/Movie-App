import 'package:flutter/material.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget('Offers', bold: true, size: 22,),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: Colors.black,
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    return Container();
  }
}