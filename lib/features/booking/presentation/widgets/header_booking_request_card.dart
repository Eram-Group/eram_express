import 'package:eram_express/app/navigation.dart';
import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express/features/booking/domain/Entities/bid_entity.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/iconsax_icons.dart';

class HeaderBookingRequestCard extends StatelessWidget {
  final BidEntity bid;
  const HeaderBookingRequestCard({super.key, required this.bid});

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
            bid.provider.fullName,
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

          _buildRating(3), // مستنياها ترجع من ال api
        ],
      ),
    ]);
  }
}

Widget _buildRating(double averageRating) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      for (int i = 0; i < 5; i++)
        Padding(
          padding: EdgeInsets.all(0),
          child: Icon(
            i < averageRating ? Iconsax.star1 : Iconsax.star,
            size: i < averageRating
                ? 22
                : 15, // حاسه الاحسن يبقي svg  علشان مقاسات
            color: i < averageRating ? AppColor.starcolor : Colors.black,
          ),
        ),
      const Gap(3),
      Text(
        averageRating.toString(),
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
