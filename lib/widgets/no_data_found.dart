import 'package:flutter/material.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AssetPath.noData,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 5,
        ),
        TextWidget(
          " No Data Found",
          size: 20,
          color: Colors.grey[400],
          bold: true,
        )
      ],
    ));
  }
}
