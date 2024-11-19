import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  final String title;
  const CustomAppBar({super.key, required this.title});
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "outfit",
          fontWeight: FontWeight.w500,
          fontSize: Responsive.getResponsiveFontSize(context, fontSize: 20),
          height:
              20.8 / Responsive.getResponsiveFontSize(context, fontSize: 20),
          color: AppColor.blacktext,
        ),
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 7),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColor.bordercolor,
              width: 1.5,
            ),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
