import 'package:cached_network_image/cached_network_image.dart';
import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../app/iconsax_icons.dart';
import '../../../../common/models/provider_model.dart';
import '../../../../common/models/rating_model.dart';

class HeaderBookingRequestCard extends StatelessWidget {
  final ProviderModel provider;
  const HeaderBookingRequestCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 50.0,
        height: 50.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: provider.image ?? '', 
            placeholder: (context, url) => Container(
                width: 50.0, height: 50.0, color: AppColor.borderColor),
            errorWidget: (context, url, error) => 
            Center(
              child: SvgPicture.asset(
                'assets/icons/user.svg',
              ),
              ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const Gap(10),
      Column(
        children: [
          Text(
            provider.fullName,
            style: TextStyle(
              fontFamily: "outfits",
              color: AppColor.blackText,
              fontSize: Responsive.getResponsiveFontSize(context, fontSize: 17),
              fontWeight: FontWeight.w500,
              height: 18.2 /Responsive.getResponsiveFontSize(context, fontSize: 17),
            ),
          ),
          const Gap(5),
          _buildRating(provider.rating,context), 
        ],
      ),
    ]);
  }
}

Widget _buildRating(RatingModel rating ,BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      for (int i = 0; i < 5; i++)
        Padding(
          padding:const EdgeInsets.all(0),
          child: Icon(
            i < rating.totalRatings ? Iconsax.star1 : Iconsax.star,
            size: i < rating.totalRatings
                ? 22
                : 15, // حاسه الاحسن يبقي svg  علشان مقاسات
            color: i < rating.totalRatings ? AppColor.starColor : Colors.black,
          ),
        ),
      const Gap(3),
      Text(
        rating.averageRating.toString(),
        style: TextStyle(
          fontFamily: "outfit",
          fontWeight: FontWeight.w400,
          color: AppColor.lightGrey,
          fontSize: Responsive.getResponsiveFontSize(
              context,
              fontSize: 15),
          height: 21.6 /
              Responsive.getResponsiveFontSize(context,
                  fontSize: 15),
        ),
      ),
    ],
  );
}
