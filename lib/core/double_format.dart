import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:legend_cinema/constants/app_constant.dart';

extension DoubleExtension on double {
  String format([String pattern = AppConstant.decimalFormat]) {
    try {
      final formattedValue = NumberFormat(pattern, 'en').format(this);
      debugPrint('Formatted Value: $formattedValue');
      return formattedValue;
    } catch (e) {
      final fallbackValue = NumberFormat(AppConstant.decimalFormat, 'en').format(this);
      debugPrint('Fallback Formatted Value: $fallbackValue');
      return fallbackValue;
    }
  }

  String get decimalized {
    final splits = toStringAsFixed(2).split('.');
    if (double.parse(splits[1]) == .0) {
      return format(AppConstant.noneDecimalFormat);
    }
    return format(AppConstant.decimalFormat);
  }
}
