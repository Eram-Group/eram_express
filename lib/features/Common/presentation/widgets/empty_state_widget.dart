import 'package:eram_express/core/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../home/modals/cargo_categories-modal.dart';

//ToDo   convert to skenelozier

class EmptyLoadingWidget extends StatelessWidget {
  const EmptyLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildemptyContainer();
        });
  }
}
Widget _buildemptyContainer() {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ).copyWith(bottom: 0),
    child: Skeleton(
      child: Container(
        height: 90,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColor.bordercolor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
        ),
      ),
    ),
  );
}
