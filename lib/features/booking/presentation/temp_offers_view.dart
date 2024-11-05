import 'package:eram_express/app/navigation.dart';
import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express/features/Common/presentation/widgets/SvgIcon.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';

import 'package:eram_express_shared/core/utils/responsive.dart';

import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../app/iconsax_icons.dart';
import '../../accepet_order_modal.dart';
import '../../authentication/presentation/views/modals/registered_successfully_modal.dart';
import '../../cancel_order_modal.dart';

class offersView extends StatelessWidget {
  const offersView({super.key});
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
                child: Column(
                  children: [
                    _buildComingOrder(context),
                    _buildOfferCard(context),
                    _buildOfferCard(context),
                    // إذا أردت إضافة المزيد من بطاقات العرض
                    // _buildOfferCard(context),
                    // _buildOfferCard(context),
                  ],
                ),
              ),
            ),
            const Spacer(),
            _buildcancelContainer(context), // زر الإلغاء سيكون دائمًا في الأسفل
          ],
        ),
      ),
    );
  }
}

Widget _buildOfferCard(BuildContext context) {
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
            _buildHeader(context),
            const SizedBox(height: 10), // Changed Gap to SizedBox
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: context.tt('Delivery cost', "تكلفة التوصيل"),
                    style: TextStyle(
                      fontFamily: "outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 25.2 / 16,
                      color: AppColor.lightGrey,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "   "),
                      TextSpan(
                        text: "\$",
                        style: TextStyle(
                          fontFamily: "outfit",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.2,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: "3,382.00", // Use comma for thousands
                        style: TextStyle(
                          fontFamily: "outfit",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.2,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
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

Widget _buildHeader(BuildContext context) {
  return Row(
    children: [
      CircleAvatar(
        radius: 28,
        backgroundImage: AssetImage("assets/images/profile.png"),
      ),
      Column(
        children: [
          Text(
            "Muhammad Ali",
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
          _buildRating(4),
        ],
      ),
    ],
  );
}

class CustomSmallButton extends StatelessWidget {
  final Color? color;
  final String text;
  final Color? colortext;
  final Color? colorborder;
  final EdgeInsetsGeometry? padding;
  const CustomSmallButton({
    this.color = AppColor.primaryColor,
    required this.text,
    this.colortext = Colors.white,
    this.colorborder = AppColor.primaryColor,
    this.padding = const EdgeInsets.all(10.0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await AcceptOrderModal().show(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: colorborder ?? AppColor.bordercolor,
            )),
        padding: padding,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colortext,
            fontWeight: FontWeight.w500,
            fontFamily: "outfit",
            fontSize: Responsive.getResponsiveFontSize(context, fontSize: 16),
            height:
                20.8 / Responsive.getResponsiveFontSize(context, fontSize: 16),
          ),
        ),
      ),
    );
  }
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
