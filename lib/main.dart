import 'package:flutter/material.dart';
import 'package:legend_cinema/config/app_config.dart';
import 'package:shared_value/shared_value.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  runApp(
      SharedValue.wrapApp(const LegendCinemaApp())
    ); 
}

// void main() => runApp(const LegendCinemaApp());