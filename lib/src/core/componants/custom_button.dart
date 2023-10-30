import 'package:flutter/material.dart';
import 'package:task/src/core/constants/colors.dart';

import '../constants/styles.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final Widget? widget;
  final bool activate;
  final void Function()? onTap;
  const CustomButton({
    Key? key,
    this.label,
    this.icon,
    this.widget,
    this.activate = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: activate ? AppColors.primaryColor : AppColors.lightGrey2,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: widget ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) icon!,
                Text(
                  label ?? " ",
                  style: AppStyles.textStyle14.copyWith(
                    color: activate ? AppColors.white : AppColors.darkGrey2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
