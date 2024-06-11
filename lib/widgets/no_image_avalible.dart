import 'package:flutter/material.dart';
import 'package:legend_cinema/constants/asset_path.dart';

class NoImageAvailable extends StatelessWidget {
  const NoImageAvailable({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          fit: BoxFit.contain,
          AssetPath.noImage,
          color: Theme.of(context).dividerColor.withOpacity(0.5),
        ),
      ),
    );
  }
}