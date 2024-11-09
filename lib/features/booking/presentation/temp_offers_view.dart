import 'package:eram_express/app/navigation.dart';
import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express/features/Common/presentation/widgets/SvgIcon.dart';
import 'package:eram_express/features/booking/domain/Entities/bid_entity.dart';
import 'package:eram_express/features/booking/domain/Entities/booking_request_entity.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';

import 'package:eram_express_shared/core/utils/responsive.dart';

import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../app/iconsax_icons.dart';
import '../../accepet_order_modal.dart';
import '../../authentication/presentation/views/modals/registered_successfully_modal.dart';
import '../../cancel_order_modal.dart';
import 'views/booking_request_view_controller.dart';
import 'views/booking_request_view_state.dart';
import 'widgets/custom_small_button.dart';
import 'widgets/delivery_cost.dart';
import 'widgets/header_booking_request_card.dart';

class OffersViewArguments {
  List<BidEntity> bidding; 
  
  OffersViewArguments({
    required this.bidding,
  });
}

class OffersView extends StatelessWidget {
  
  final OffersViewArguments offersViewArguments;
  const OffersView({super.key, required this.offersViewArguments});

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
            height: 30, // لإضافة شكل دائري للزر
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
        child: Column(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10)
                  .copyWith(bottom: 0),
              child: Expanded(
                child: BlocBuilder<BookingRequestViewController,
                    BookingRequestViewState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        _buildComingOrder(context),
                        _buildBiddings(context, offersViewArguments.bidding)
                      ],
                    );
                  },
                ),
              ),
            ),
            const Spacer(),
            _buildcancelContainer(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildBiddings(BuildContext context, List<BidEntity> biddings) 
{
  return Column
  (
    children: biddings.map((item) => _buildOfferCard(context, item)).toList(),
  );

}



Widget _buildOfferCard(BuildContext context, BidEntity item) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColor.bordercolor,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderBookingRequestCard(
              bid: item,
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DeliveryCost(
                  amount: item.amount,
                  amountCurrency: item.amountCurrency,
                ),
                CustomSmallButton(text: context.tt("Accept", "قبول")),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildComingOrder(BuildContext context) {
  return Container(
    height: 41,
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

Widget _buildcancelContainer(BuildContext context) {
  return Container(
      width: Responsive.screenWidth,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)
          .copyWith(bottom: 20),
      height: Responsive.screenHeight! * .12,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -5),
            blurRadius: 30,
            spreadRadius: 4,
            color: Color(0xff0C0C0D17).withOpacity(0.09),
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
                        Responsive.getResponsiveFontSize(context, fontSize: 18),
                    fontSize: Responsive.getResponsiveFontSize(context,
                        fontSize: 18)),
              ))
        ],
      ));
}

Widget _buildEmptystate(BuildContext context) {
  return Column(
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
  );
}
