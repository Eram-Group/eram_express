import 'package:eram_express/features/booking/presentation/views/viewsmodel/bid_view_model.dart';
import 'package:eram_express/features/booking/presentation/widgets/accept_offer_card.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:eram_express_shared/presentation/widgets/clickable.dart';
import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/app_colors.dart';
import '../../../Common/presentation/widgets/SvgIcon.dart';
import '../../../accepet_order_modal.dart';
import 'booking_request_view_controller.dart';
import 'booking_request_view_state.dart';

class OfferViewArguments {
  int id;
  final BookingRequestViewController cubit;
  OfferViewArguments({required this.cubit, required this.id});
}

class OffersView extends StatelessWidget {
  final OfferViewArguments arguments;
  const OffersView({super.key, required this.arguments});
  static const String route = '/offers';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          context.tt("best offers", "افضل العروض"),
          style: TextStyle(
            fontFamily: "outfit",
            fontWeight: FontWeight.w500,
            fontSize: Responsive.getResponsiveFontSize(context, fontSize: 20),
            height:
                20.8 / Responsive.getResponsiveFontSize(context, fontSize: 20),
            color: AppColor.blacktext,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 7),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.bordercolor,
                width: 1.5,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(children: [
          BlocConsumer<BookingRequestViewController, BookingRequestViewState>(
            bloc: arguments.cubit,
            listener: (context, state) {
              if (state is AcceptbookingRequest) {
                const AcceptOrderModal().show(context);
              }
            },
            builder: (context, state) {
              List<BidViewModel> bids =
                  arguments.cubit.getBidding(arguments.id);
              logger.debug(bids.length.toString());
              return bids.isNotEmpty
                  ? Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 10)
                                  .copyWith(bottom: 0),
                              child: Column(
                                children: [
                                  _buildComingOrder(context),
                                  _buildBiddings(context, bids),
                                ],
                              ))))
                  : _buildEmptystate(context);
            },
          ),
          _buildCancelContainer(context),
        ]),
      ),
    );
  }

  Widget _buildCancelContainer(BuildContext context) {
    return Clickable(
        onTap: () {
          // for temp
          arguments.cubit.listBookingRequest();
        },
        child: Container(
            width: Responsive.screenWidth,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
                .copyWith(bottom: 20),
            height: Responsive.screenHeight! * .12,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -5),
                  blurRadius: 30,
                  spreadRadius: 4,
                  color: const Color(0xff0C0C0D17).withOpacity(0.09),
                ),
              ],
            ),
            //height: Responsive.screenHeight! * .25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    color: Colors.white,
                    width: Responsive.screenWidth! * 0.9,
                    child: Text(
                      "Cancel Order",
                      style: TextStyle(
                          color: AppColor.blacktext,
                          fontWeight: FontWeight.w500,
                          height: 20.8 /
                              Responsive.getResponsiveFontSize(context,
                                  fontSize: 18),
                          fontSize: Responsive.getResponsiveFontSize(context,
                              fontSize: 18)),
                    ))
              ],
            )));
  }

  Widget _buildBiddings(BuildContext context, List<BidViewModel> biddings) {
    return Column(
      children: biddings
          .map((bidding) => AcceptOfferCard(
                item: bidding,
                onAcceptBidding: () {
                  arguments.cubit.acceptBidding(bidding);
                },
              ))
          .toList(),
    );
  }
}

Widget _buildComingOrder(BuildContext context) {
  return Container(
    height: Responsive.screenHeight! * 0.055,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: AppColor.ligthgreen,
      borderRadius: BorderRadius.circular(10),
    ),
    width: Responsive.screenWidth,
    child: Row(
      children: [
        const SvgIcon(
          asset: "tick-circle",
          color: AppColor.secondaryColor,
          size: 20,
        ),
        const Gap(10),
        Text(
          context.tt("Offers are coming now", "العروض قادمة الآن"),
          style: TextStyle(
            color: AppColor.secondaryColor,
            fontWeight: FontWeight.w400,
            fontFamily: "outfits",
            fontSize: Responsive.getResponsiveFontSize(context, fontSize: 16),
            height:
                20.8 / Responsive.getResponsiveFontSize(context, fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

Widget _buildEmptystate(BuildContext context) {
  return Expanded(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SvgIcon(
        asset: "Spinner-Two-Circles",
        size: 50,
      ),
      Text(
        context.tt("No offers exist", "لا توجد عروض"),
        style: TextStyle(
          fontFamily: "Outfit",
          fontWeight: FontWeight.w600,
          fontSize: Responsive.getResponsiveFontSize(context, fontSize: 22),
          height:
              28.6 / Responsive.getResponsiveFontSize(context, fontSize: 22),
        ),
      ),
      Text(
        context.tt("Right now no Offers exit, Offers are coming now",
            "لا توجد عروض حالياً، العروض قادمة الآن."),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Outfit",
          fontWeight: FontWeight.w400,
          fontSize: Responsive.getResponsiveFontSize(context, fontSize: 14),
          height:
              28.6 / Responsive.getResponsiveFontSize(context, fontSize: 14),
          color: AppColor.lightGrey,
        ),
      )
    ],
  ));
}
