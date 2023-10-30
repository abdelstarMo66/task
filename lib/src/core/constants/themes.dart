import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/src/core/constants/colors.dart';
import 'package:task/src/core/constants/styles.dart';

class LightTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0.0,
      centerTitle: true,
      titleTextStyle: AppStyles.titleAppBarStyle,
      iconTheme: IconThemeData(color: AppColors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark),
    ),
  );
}

class DarkTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
  );
}
