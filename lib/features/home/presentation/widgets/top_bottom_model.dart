import 'package:flutter/cupertino.dart';

class TopBottomModel extends StatelessWidget {
  const TopBottomModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Container(
          width: 60,
          height: 5,
          decoration: BoxDecoration(
            color:const Color(0xffDFE2EB),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}
