import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
      textTheme: GoogleFonts.outfitTextTheme().apply(
    bodyColor: Colors.black,
  ));
}
