import 'package:eram_express/features/Common/presentation/widgets/SvgIcon.dart';
import 'package:eram_express/features/booking/data/models/booking_request_model.dart';
import 'package:eram_express/features/booking/domain/Entities/booking_request_entity.dart';
import 'package:eram_express/features/booking/presentation/views/viewsmodel/booking_request_view_model.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:eram_express_shared/presentation/widgets/clickable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/widgets/dot_line.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_text_style.dart';
import '../temp_offers_view.dart';
import 'header_booking_request_card.dart';

class BookingRequestCard extends StatelessWidget {
  final BookingRequestViewModel bookingRequest;
  final void Function()? onTap;
  BookingRequestCard({super.key, required this.bookingRequest ,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Clickable(
        onTap: onTap,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: Responsive.screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.bordercolor,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //HeaderBookingRequestCard(provider: bookingRequest.bids[0].provider,),
            const Gap(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SvgIcon(asset: "darkCalendar", color: AppColor.darkGrey),
                const Gap(20),
                Text(
                  bookingRequest.bookingDate,
                  style: AppTextStyles.smalltitle,
                ),
              ],
            ),
            _buildCard(context, bookingRequest),
          ],
        ));
  }
}

Widget _buildStatusRow(String icon, String title, String address) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SvgIcon(asset: icon),
      const Gap(14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.smalltitle),
            Text(
              address,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: "outfit",
                color: AppColor.blacktext,
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget _buildCard(BuildContext context, BookingRequestViewModel booking) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildStatusRow("source", context.tt("Starting point", "نقطه البداية"),
          booking.pickingLocation.address),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomPaint(
            size: Size(1, 20), // عرض الخط وارتفاعه
            painter: DottedLinePainter(),
          )),
      _buildStatusRow("destinationn", context.tt("End point", "نقطه النهاية"),
          booking.destinationLocation.address),
    ],
  );
}