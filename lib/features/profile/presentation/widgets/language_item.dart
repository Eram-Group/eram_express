import 'package:eram_express/features/profile/presentation/views/profile_presentation/profile_view.dart';
import 'package:eram_express_shared/core/app_colors.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:eram_express_shared/presentation/widgets/clickable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/models/language_model.dart';

class LanguageItem extends StatelessWidget {
  final LanguageModel languageoption;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageItem({
    Key? key,
    required this.languageoption,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Clickable(
      margin: const EdgeInsets.symmetric(vertical: 5),
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isSelected ? Colors.green : AppColor.bordercolor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: Responsive.getResponsiveFontSize(context, fontSize: 20),
                child: SvgIcon(
                  asset: languageoption.flag,
                ),
              ),
              SizedBox(
                  width:
                      Responsive.getResponsiveFontSize(context, fontSize: 20)),
              Text(
                languageoption.language,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Spacer(),
              isSelected
                  ? const SvgIcon(
                      asset: 'tick-circle',
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
