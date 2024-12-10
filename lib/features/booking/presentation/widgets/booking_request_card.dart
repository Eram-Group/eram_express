import 'package:eram_express/features/Common/presentation/widgets/SvgIcon.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:eram_express_shared/presentation/widgets/clickable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../app/ServiceLocator.dart';
import '../../../../common/widgets/dot_line.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_text_style.dart';
import '../../data/models/bid_model.dart';
import '../../data/models/booking_request_model.dart';
import 'accept_offer_card.dart';

class BookingRequestCard extends StatelessWidget {
  final BookingRequestModel bookingRequest;
  final void Function(BidModel)? onTap;
  final void Function()? showMoreTap;
  const BookingRequestCard({
    super.key,
    required this.bookingRequest,
    required this.onTap,
    required this.showMoreTap,
  });
  @override
  Widget build(BuildContext context) {
    return Clickable(
        onTap: showMoreTap,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        width: Responsive.screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.borderColor,
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
                  style: AppTextStyles.smallTitle,
                ),
              ],
            ),
            _buildCard(context, bookingRequest),
            const Gap(10),
            bookingRequest.bids.isEmpty
                ? _buildNoBiddingContainer(context)
                : _buildBiddings(bookingRequest.bids),
          ],
        ));
  }

  Widget _buildBiddings(List<BidModel> bids) {
    return BlocProvider<ExpansionTileCubit>(
        create: (context) => sl(),
        child: Column(
          children: [
            BlocBuilder<ExpansionTileCubit, bool>(
              builder: (context, isExpanded) {
                return Center(
                    child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ExpansionTile(
                        minTileHeight: 10,
                        tilePadding: EdgeInsets.symmetric(
                            horizontal: context.read<ExpansionTileCubit>().state
                                ? 5
                                : 20,
                            vertical: 5),
                        collapsedBackgroundColor: const Color(0xffF8F8F8),
                        title: Row(
                          children: [
                            Text(context.tt("New Bid", "عرض جديد"),
                                style: TextStyle(
                                    fontSize: Responsive.getResponsiveFontSize(
                                        context,
                                        fontSize: 16),
                                    color: AppColor.primaryColor,
                                    height: 20.8 /
                                        Responsive.getResponsiveFontSize(
                                            context,
                                            fontSize: 16),
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w600)),
                            const Gap(10),
                            Container(
                              height: 22,
                              width: 22,
                              decoration: const BoxDecoration(
                                  color: AppColor.primaryColor,
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Text(
                                  bids.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )

                            //bidds.length.toString()
                          ],
                        ),
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.transparent)),
                        trailing: context.read<ExpansionTileCubit>().state
                            ? TextButton(
                                onPressed: showMoreTap,
                                child: Text(
                                  context.tt("Show more", "عرض المزيد"),
                                  style: TextStyle(
                                    fontSize: Responsive.getResponsiveFontSize(
                                        context,
                                        fontSize: 14),
                                    color: AppColor.blackText,
                                    fontFamily: 'outfit',
                                    fontWeight: FontWeight.w600,
                                    height: 25.2 /
                                        Responsive.getResponsiveFontSize(
                                            context,
                                            fontSize: 14),
                                  ),
                                ),
                              )
                            : const SvgIcon(
                                asset: 'arrow',
                                size: 20,
                              ),
                        onExpansionChanged: (bool expanding) {
                          context.read<ExpansionTileCubit>().toggleExpansion();
                        },
                        children: List.generate(
                            bids.length,
                            (index) => AcceptOfferCard(
                                  backgroundColor: const Color(0xffF8F8F8),
                                  item: bids[index],
                                  onAcceptBidding: () {
                                    onTap?.call(bids[index]);
                                    //arguments.cubit.acceptBidding(bidding);
                                  },
                                )),
                      )),
                ));
              },
            ),
          ],
        ));
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
              Text(title, style: AppTextStyles.smallTitle),
              Text(
                address,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "outfit",
                  color: AppColor.blackText,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

// redesign this card depend on  https://stackoverflow.com/questions/61822182/flutter-expand-column-inside-row/64331750#64331750
  Widget _buildCard(BuildContext context, BookingRequestModel booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatusRow("source", context.tt("Starting point", "نقطه البداية"),
            booking.pickingLocation.address),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomPaint(
              size: const Size(1, 20), // عرض الخط وارتفاعه
              painter: DottedLinePainter(),
            )),
        _buildStatusRow("destination", context.tt("End point", "نقطه النهاية"),
            booking.destinationLocation.address),
      ],
    );
  }

  Widget _buildNoBiddingContainer(BuildContext context) {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          context.tt("No bidings right now", "لا عروض حتى الآن"),
          style: TextStyle(
              color: const Color(0xff666876),
              fontFamily: 'outfit',
              fontWeight: FontWeight.w500,
              fontSize: Responsive.getResponsiveFontSize(context, fontSize: 16),
              height: 20.8 /
                  Responsive.getResponsiveFontSize(context, fontSize: 16)),
        ),
      ),
    ));
  }
}

class ExpansionTileCubit extends Cubit<bool> {
  ExpansionTileCubit() : super(false);

  void toggleExpansion() => emit(!state);
}
