import 'package:flutter/material.dart';

class FontSizeManager {
  static const double largeTitle = 31.0;
  static const double title1 = 25.0;
  static const double title2 = 19.0;
  static const double title3 = 17.0;
  static const double headlineBody = 14.0;
  static const double callout = 13.0;
  static const double subheadFootnote = 12.0;
  static const double caption = 11.0;
}

class ButtonSizeManager {
  static const double regular = 48.0;
}

class SizeManager {
  static const double textFieldContainerHeight = 34.0;
}

class BorderRadiusManager {
  static BorderRadius textfieldRadius = BorderRadius.circular(6.0);
  static Radius dottedTextFieldRadius = const Radius.circular(6.0);
}

class BottomAppBarManager {
  static const double regular = 58.0;
}

class PaddingMarginManager {
  static const EdgeInsets allSuperView = EdgeInsets.all(16);
  static const EdgeInsets horizontallySuperView = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets listSuperView = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  static const EdgeInsets labelTextField = EdgeInsets.fromLTRB(24, 0, 16, 0);
  static const EdgeInsets textField = EdgeInsets.fromLTRB(16, 0, 16, 0);
  static const EdgeInsets onlyRight6 = EdgeInsets.fromLTRB(0, 0, 6, 0);
}

class SizedBoxManager {
  static const double largeSpace = 64.0;
}

class ColorManager {
  static const placeholder = Color.fromRGBO(198, 198, 200, 1);
  static const primary = Color.fromRGBO(39, 85, 171, 1);
  static const blackText = Color.fromRGBO(0, 0, 0, 1);
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const backgroundPage = Color.fromRGBO(242, 242, 247, 1);
  static const subheadFootnote = Color.fromRGBO(60, 60, 67, 0.6);
  static const separator = Color.fromRGBO(0, 0, 0, 0.1);
  static const negative = Color.fromRGBO(255, 59, 48, 1);
  static const disabledTextIcon = Colors.black26;
  static const disabledBackground = Colors.black12;
}

class ColorSchemeManager {
  final colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.light,
    primary: ColorManager.primary,
    seedColor: ColorManager.primary,
  );
}
