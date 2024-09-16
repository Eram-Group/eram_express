import 'package:flutter/material.dart';

class Responsive {
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;
  static const double tablet = 550;

  static void init(BuildContext context) {
    print("Initializing responsive dimensions");
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;
    print(screenHeight);
    defaultSize = orientation == Orientation.landscape
        ? screenHeight! * .024
        : screenWidth! * .024;
  }

  static double getResponsiveFontSize(BuildContext context,
      {required double fontSize}) {
    double scaleFactor = getScaleFactor();
    double responsiveFontSize = fontSize * scaleFactor;

    return responsiveFontSize;
  }

  static double getScaleFactor() {
    if (screenWidth == null) {
      throw Exception(
          'Responsive.init() must be called before using getScaleFactor()');
    }

    if (screenWidth! < tablet) {
      return screenWidth! / 400;
    } else {
      return screenWidth! / 520;
    }
  }

  static double getResponsivebyHeigth(BuildContext context,
      {required double fontSize}) {
    double scaleFactor = getScaleFactorheigth();
    double responsiveFontSize = fontSize * scaleFactor;

    return responsiveFontSize;
  }

// ههبده
  static double getScaleFactorheigth() {
    if (screenWidth == null) {
      throw Exception(
          'Responsive.init() must be called before using getScaleFactor()');
    }

    if (screenHeight! < 900) {
      return screenHeight! / 700;
    } else {
      return screenHeight! / 950;
    }
  }

  static T responsiveValue<T>({
    required T mobileValue,
    required T tabletValue,
  }) {
    if (screenWidth! >= 780) {
      return tabletValue;
    } else {
      return mobileValue;
    }
  }
}
