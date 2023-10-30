import 'package:flutter/material.dart';
import 'package:task/src/core/constants/const_variables.dart';

import 'colors.dart';

class AppStyles {
  static const TextStyle titleAppBarStyle = TextStyle(
    color: AppColors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    fontFamily: AppConstants.fontFamily,
  );
  static const TextStyle textStyle16 = TextStyle(
    color: AppColors.lightBlack,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: AppConstants.fontFamily,
  );
  static const TextStyle textStyle12 = TextStyle(
    color: AppColors.lightBlack,
    fontSize: 12,
    fontFamily: 'Alexandria',
    fontWeight: FontWeight.w400,
  );
  static const TextStyle textStyle14 = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 14,
    fontFamily: 'Alexandria',
    fontWeight: FontWeight.w500,
  );
  static const TextStyle textStyle10 = TextStyle(
    color: AppColors.darkGrey,
    fontSize: 10,
    fontFamily: 'Alexandria',
    fontWeight: FontWeight.w400,
  );
  static const TextStyle textStyle24 = TextStyle(
    color: AppColors.lightBlack,
    fontSize: 24,
    fontFamily: 'Alexandria',
    fontWeight: FontWeight.w400,
  );
}
