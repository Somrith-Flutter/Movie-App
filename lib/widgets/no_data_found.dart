import 'package:flutter/material.dart';
import 'package:legend_cinema/constants/asset_path.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AssetPath.noData,fit: BoxFit.cover,)
      ),
    );
  }
}
