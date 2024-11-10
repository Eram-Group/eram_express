import 'package:eram_express/app/navigation.dart';
import 'package:eram_express/common/viewmodels/provider_view_model.dart';
import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express/features/booking/domain/Entities/bid_entity.dart';
import 'package:eram_express/features/booking/presentation/views/viewsmodel/bid_view_model.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/iconsax_icons.dart';
import '../../../../common/viewmodels/rating_view_model.dart';

class HeaderBookingRequestCard extends StatelessWidget {
  final ProviderViewModel provider;
  const HeaderBookingRequestCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const CircleAvatar(
        radius: 28,
        backgroundImage: AssetImage("assets/images/profile.png"),
      ),
      Column(
        children: [
          Text(
            provider.fullName,
            style: TextStyle(
              fontFamily: "outfits",
              color: AppColor.blacktext,
              fontSize: Responsive.getResponsiveFontSize(context, fontSize: 17),
              fontWeight: FontWeight.w500,
              height: 18.2 /
                  Responsive.getResponsiveFontSize(context, fontSize: 17),
            ),
          ),
          const Gap(5),

          _buildRating(provider.rating), // مستنياها ترجع من ال api
        ],
      ),
    ]);
  }
}

Widget _buildRating(RatingViewModel rating) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      for (int i = 0; i < 5; i++)
        Padding(
          padding: EdgeInsets.all(0),
          child: Icon(
            i < rating.totalRatings ? Iconsax.star1 : Iconsax.star,
            size: i < rating.totalRatings
                ? 22
                : 15, // حاسه الاحسن يبقي svg  علشان مقاسات
            color: i < rating.totalRatings ? AppColor.starcolor : Colors.black,
          ),
        ),
      const Gap(3),
      Text(
        rating. averageRating.toString(),
        style: TextStyle(
          fontFamily: "outfit",
          fontWeight: FontWeight.w400,
          color: AppColor.lightGrey,
          fontSize: Responsive.getResponsiveFontSize(
              NavigationService.globalContext,
              fontSize: 15),
          height: 21.6 /
              Responsive.getResponsiveFontSize(NavigationService.globalContext,
                  fontSize: 15),
        ),
      ),
    ],
  );
}
