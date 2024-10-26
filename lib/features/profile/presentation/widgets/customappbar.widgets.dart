import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: Container(
        padding: EdgeInsets.all(8.0), 
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
