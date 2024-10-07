import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stm_getx/_common/constants/app_constants.dart';

import '../../_services/theme_services/w_custom_theme_builder.dart';

class CustomButtonWidget extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Color? borderColor;
  final Color? bgColor;
  final void Function()? onTapFunc;
  final IconData? icon;
  const CustomButtonWidget(
      {super.key,
      required this.label,
      required this.labelColor,
      this.borderColor,
      this.bgColor,
      required this.onTapFunc,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return MyThemeBuilder(
      builder: (context, theme, themeController) {
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: Size(double.infinity, Get.height * 0.06),
              backgroundColor: bgColor ?? theme.primary,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: borderColor ?? theme.primarySoft),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppConstants.baseBorderRadius),
                ),
              ),
            ),
            onPressed: onTapFunc,
            child: Row(
              mainAxisAlignment: icon == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                      color: labelColor ?? theme.text1,
                      fontWeight: AppConstants.fontWeightM),
                ),
                if (icon != null)
                  Icon(
                    icon,
                    size: AppConstants.fontSizeM,
                    color: theme.text1,
                  )
              ],
            ));
      },
    );
  }
}
