import 'package:flutter/material.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: const TextWidget(
          'Search',
          size: 22,
          bold: true,
        ),
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