import 'package:flutter/material.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget('Aboutus', bold: true, size: 22,),
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