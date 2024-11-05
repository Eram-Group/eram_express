import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle headingStyle = TextStyle(
    color: Color(0xff191D31),
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 23.4 / 18,
  );

  static TextStyle HeaderModal = const TextStyle(
    fontFamily: 'Outfit',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 22,
    height: 1.3,
    color: Color(0xFF191D31),
  );

  static TextStyle subHeaderModal = const TextStyle(
    fontFamily: 'Outfit',
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.8, // 25.2px / 14px = 1.8
    color: Color(0xFFA7A9B7),
  );
}
