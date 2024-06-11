import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:legend_cinema/config/themes/dark_theme.dart';

part 'app_theme.g.dart';
abstract class AppTheme extends Equatable {
  const AppTheme(this.themeOptions);
  final AppThemeOptions? themeOptions;
  ThemeData get themeData;
  Widget get icon;
  String getKey();
}

class AppThemeFactory {
  static AppTheme buildTheme(String? key, {AppThemeOptions? themeOptions}) {
    switch (key) {
      case DarkTheme.key:
        return DarkTheme(themeOptions);
      default:
        return AutoTheme(themeOptions);
    }
  }

  static AppTheme toggleTheme(String? key, {AppThemeOptions? themeOptions}) {
    switch (key) {
      case DarkTheme.key:
        return AutoTheme(themeOptions);
       default:
        return AutoTheme(themeOptions);
    }
  }
}

class AutoTheme extends AppTheme {
  static const String key = 'AutoTheme';
  const AutoTheme(super.themeOptions);

  @override
  ThemeData get themeData {
    return darkTheme(themeOptions);
  }

  @override
  Widget get icon => const Icon(Icons.brightness_auto, key: Key('auto_mode'));

  @override
  String getKey() => key;

  @override
  List<Object?> get props => [themeData, icon, getKey()];
}

class DarkTheme extends AppTheme {
  static const String key = 'DarkTheme';
  const DarkTheme(super.themeOptions);

  @override
  ThemeData get themeData => darkTheme(themeOptions);

  @override
  Widget get icon => const Icon(Icons.dark_mode, key: Key('dark_mode'));

  @override
  String getKey() => key;

  @override
  List<Object?> get props => [themeData, icon, getKey()];
}


@JsonSerializable()
class AppThemeOptions extends Equatable {
  const AppThemeOptions({
    this.primaryColorHex,
    this.fontFamily,
  });

  final String? primaryColorHex;
  final String? fontFamily;

  @override
  List<Object?> get props => [primaryColorHex, fontFamily];

  AppThemeOptions copyWith({String? primaryColorHex, String? fontFamily}) {
    return AppThemeOptions(
      primaryColorHex: primaryColorHex ?? this.primaryColorHex,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }

  factory AppThemeOptions.fromJson(Map<String, dynamic> json) =>
      _$AppThemeOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$AppThemeOptionsToJson(this);
}
