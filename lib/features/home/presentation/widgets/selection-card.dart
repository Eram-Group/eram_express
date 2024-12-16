import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../Common/presentation/widgets/SvgIcon.dart';

class SelectionCard extends StatelessWidget {
  final Future<void> Function() onTap;

  final String label;
  final String iconName;
  final String? selectedValue;
  final bool isValidate;

  const SelectionCard({
    Key? key,
    required this.onTap,
    required this.label,
    required this.iconName,
    required this.selectedValue,
    this.isValidate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = selectedValue != null && selectedValue != " "
        ? Colors.black
        : AppColor.lightText;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
            onTap: () async {
              await onTap();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isValidate ? AppColor.borderColor : Colors.red,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 25.2 / 20,
                        ),
                      ),
                    ),
                    SvgIcon(
                      asset: iconName,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          isValidate
              ? const SizedBox()
              : Text(
                  context.tt(
                      "You should select it first", "يجب أن تختاره أولاً."),
                  style:const  TextStyle(
                    fontFamily: 'outfit',
                    color: Colors.red,
                  ),
                )
        ]));
  }
}
