import 'package:flutter/material.dart';

import '../../data/models/menu_option_model.dart';

class listtitleCard extends StatelessWidget {
  MenuOptionModel menuOption;
  listtitleCard({required this.menuOption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          menuOption.onTap();
        },
        child: Container(
          height: 55,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Color(0xFFF3F3F3),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.white,
          ),
          child: Row(
            children: [
              menuOption.icon,
              SizedBox(
                width: 10,
              ),
              Text(
                menuOption.title,
                style: TextStyle(
                  color: Color(0xFF191D31),
                  fontSize: 14,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w500,
                  height: 0.09,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
