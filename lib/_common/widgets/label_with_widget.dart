import 'package:flutter/widgets.dart';
import 'package:stm_getx/_services/others/extensions.dart';

import '../../_services/theme_services/w_custom_theme_builder.dart';
import '../constants/app_constants.dart';

class LabelWithWidget extends StatelessWidget {
  final String label;
  final Widget child;
  final Color? lableColor;
  const LabelWithWidget(
      {super.key, required this.label, required this.child, this.lableColor});

  @override
  Widget build(BuildContext context) {
    return MyThemeBuilder(
      builder: (context, theme, themeController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                  fontWeight: AppConstants.fontWeightM,
                  color: lableColor ?? theme.text1),
            ),
            2.heightBox(),
            child
          ],
        );
      },
    );
  }
}
