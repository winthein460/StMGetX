import 'package:flutter/material.dart';

import '../../_services/theme_services/w_custom_theme_builder.dart';
import '../constants/app_constants.dart';

class ChildWithCustomBorder extends StatelessWidget {
  final Widget child;
  const ChildWithCustomBorder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MyThemeBuilder(
      builder: (context, theme, themeController) {
        return Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: AppConstants.basePaddingS),
            padding: EdgeInsets.symmetric(horizontal: AppConstants.basePadding),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppConstants.baseBorderRadius),
                border: Border.all(
                    color: theme.borderGray.withOpacity(0.2),
                    width: AppConstants.borderWidthXS)),
            child: child);
      },
    );
  }
}
