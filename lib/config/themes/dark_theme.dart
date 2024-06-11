import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/config/themes/app_theme.dart';
import 'package:legend_cinema/constants/app_constant.dart';

ThemeData darkTheme(AppThemeOptions? themeOptions) {
  Color primary = AppColor.primaryColor;
  String font = AppConstant.defaultFont;
  if (themeOptions != null) {
    if (themeOptions.primaryColorHex != null) {
      primary = Color(ColorHelper.fromHexString(themeOptions.primaryColorHex!));
    }
    if (themeOptions.fontFamily != null) {
      font = themeOptions.fontFamily!;
    }
  }

  return ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColor.cardDark,
    primaryColor: primary,
    secondaryHeaderColor: primary.withOpacity(0.7),
    dividerColor: AppColor.dividerDark,
    cardColor: AppColor.cardDark,
    unselectedWidgetColor: Colors.grey,
    colorScheme: ColorScheme(
      primary: primary,
      secondary: AppColor.card,
      brightness: Brightness.dark,
      background: AppColor.backgroundDark,
      error: AppColor.danger,
      onBackground: const Color(0xffB5BFD3),
      onError: AppColor.danger,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      surface: AppColor.backgroundDark,
    ),
    focusColor: Colors.transparent,
    pageTransitionsTheme: kIsWeb
        ? const PageTransitionsTheme(builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
          })
        : null,
    brightness: Brightness.dark,
    fontFamily: font,

    timePickerTheme: TimePickerThemeData(
      backgroundColor: primary,
      dialBackgroundColor: primary,
    ),
    primaryIconTheme: IconThemeData(color: primary),
    buttonTheme: const ButtonThemeData(buttonColor: AppColor.buttonLight),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(primary),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: BorderSide(
          color: primary.withOpacity(.5),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
    ),
    iconTheme: const IconThemeData(color: AppColor.white),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: AppColor.white,
      labelColor: primary,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 16,
      color: AppColor.cardDark,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: primary,
        fontSize: 14,
      ),
      iconTheme: IconThemeData(color: primary, size: 20),
      actionsIconTheme: IconThemeData(color: primary, size: 20),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColor.cardDark,
    ),
    dialogBackgroundColor: AppColor.cardDark,
    dialogTheme: const DialogTheme(
      backgroundColor: AppColor.cardDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(fontWeight: FontWeight.normal),
      prefixStyle: TextStyle(
        color: AppColor.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all<Color>(primary),
    ),
    textTheme:
        Typography.material2018(platform: defaultTargetPlatform).black.copyWith(
              bodyLarge: const TextStyle(color: Colors.white, fontSize: 14),
              bodyMedium: const TextStyle(color: AppColor.white, fontSize: 14),
              bodySmall: const TextStyle(color: Colors.white60, fontSize: 14),
              titleMedium: const TextStyle(
                color: AppColor.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              titleSmall: const TextStyle(
                color: AppColor.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              labelSmall: const TextStyle(color: Colors.white, fontSize: 10),
              labelLarge: const TextStyle(color: AppColor.white, fontSize: 14),
            ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    platform: defaultTargetPlatform,
  );
}


enum ContrastPreference { none, light, dark }

class ColorHelper {
  static int fromHexString(String argbHexString) {
    String useString = argbHexString;
    if (useString.startsWith('#')) {
      useString = useString.substring(1); 
    }
    if (useString.length < 8) {
      useString = 'FF$useString';
    }
    if (!useString.startsWith('0x')) {
      useString = '0x$useString';
    }
    return int.tryParse(useString) ?? AppColor.primaryColor.value;
  }

  static String toHex(Color color) => '#${color.value.toRadixString(16)}';
  static const double _kMinContrastModifierRange = 0.35;
  static const double _kMaxContrastModifierRange = 0.65;
  static Color blackOrWhiteContrastColor(Color sourceColor,
      {ContrastPreference prefer = ContrastPreference.none}) {
    double value = (((sourceColor.red * 299.0) +
                (sourceColor.green * 587.0) +
                (sourceColor.blue * 114.0)) /
            1000.0) /
        255.0;
    if (prefer != ContrastPreference.none) {
      if (value >= _kMinContrastModifierRange &&
          value <= _kMaxContrastModifierRange) {
        return prefer == ContrastPreference.light
            ? const Color(0xFFFFFFFF)
            : const Color(0xFF000000);
      }
    }
    return value > 0.6 ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  }
}
