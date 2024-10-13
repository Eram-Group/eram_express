import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/AppColors.dart';

class ClickBottomSheetItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Widget content;
  final String imageUrl;
  const ClickBottomSheetItem({
    Key? key,
    this.isSelected = false,
    required this.imageUrl,
    required this.onTap,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ).copyWith(bottom: 0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: isSelected ? Colors.green : AppColor.bordercolor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xffF2F4F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 50,
                      child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          placeholder: (context, url) => Container(
                                color: const Color(0xffF2F4F9),
                              ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.scaleDown),
                    ),
                  ),
                ),
                const Gap(8),
                content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
