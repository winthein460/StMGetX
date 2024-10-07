import 'package:flutter/material.dart';

import '../../_services/theme_services/w_custom_theme_builder.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MyThemeBuilder(
      builder: (context, theme, themeController) {
        return Divider(
          color: theme.borderGray.withOpacity(0.2),
          thickness: 1.6,
        );
      },
    );
  }
}
