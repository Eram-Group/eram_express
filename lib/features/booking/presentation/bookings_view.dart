import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 1,
          child: SvgPicture.asset(
            "assets/icons/profile_view.svg",
            fit: BoxFit.fill,
          ),
        ),
      ],
    ));
  }
}


