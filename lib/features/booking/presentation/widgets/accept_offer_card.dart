import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/app_colors.dart';
import '../../data/models/bid_model.dart';
import 'custom_small_button.dart';
import 'delivery_cost.dart';
import 'header_booking_request_card.dart';

class AcceptOfferCard extends StatelessWidget {
  final BidModel item;
  final Color?backgroundColor;
  final Function() onAcceptBidding;

  const AcceptOfferCard({
    super.key,
    required this.item,
    required this.onAcceptBidding,
    this.backgroundColor= Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.borderColor,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderBookingRequestCard(provider: item.provider),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DeliveryCost(
                    amount: item.amount,
                    amountCurrency: item.amountCurrency,
                  ),
                  CustomSmallButton(
                    text: context.tt(
                      "Accept",
                      "قبول",
                    ),
                    onTap: () {
                      onAcceptBidding();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}