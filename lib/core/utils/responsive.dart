import 'package:flutter/material.dart';

import '../constants.dart';

class Responsive {
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;
  static const double tablet = 500;

  static init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;

    defaultSize = orientation == Orientation.landscape
        ? screenHeight! * .024
        : screenWidth! * .024;
  }

  static double getResponsiveFontSize(context, {required double fontSize}) {
    double scaleFactor = getScaleFactor(context);
    double responsiveFontSize = fontSize * scaleFactor;

    return responsiveFontSize;
  }

  static double getScaleFactor(context) {
    double width = MediaQuery.sizeOf(context).width;
    if (width < tablet) {
      return width / 400;
    } else {
      return width / 600;
    }
  }

  static T responsiveValue<T>({
    required double screenWidth,
    required T mobileValue,
    required T tabletValue,
  }) {
    if (screenWidth >= kTabletBreakpoint) {
      return tabletValue;
    } else {
      return mobileValue;
    }
  }
}
