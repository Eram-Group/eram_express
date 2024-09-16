import 'package:dots_indicator/dots_indicator.dart';
import 'package:eram_express/app/Sharded_preference_Keys.dart';
import 'package:eram_express/app/di.dart';
import 'package:eram_express/app/presentation/AppColors.dart';
import 'package:eram_express/core/Services/Shared_preference_service.dart';
import 'package:eram_express/core/utils/responsive.dart';
import 'package:eram_express/features/Common/widgets/CustomButton.dart';
import 'package:eram_express/features/authentication/presentation/views/login_view.dart';
import 'package:eram_express/features/onboarding/data/onboarding_model.dart';
import 'package:eram_express/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoarding_body extends StatelessWidget 
{
  final bool showSkipButton;
  final OnboardingModel onboarding;
  final currentpage;
  const OnBoarding_body(
      {super.key,
      required this.showSkipButton,
      required this.onboarding,
      required this.currentpage});

  @override
  Widget build(BuildContext context) {
    final ImageOffsetleft = Responsive.responsiveValue(
      mobileValue: Responsive.getResponsiveFontSize(context, fontSize: 100),
      tabletValue: Responsive.getResponsiveFontSize(context, fontSize: 130),
    );
    final ImageOffsettop =Responsive.getResponsiveFontSize(context, fontSize: 50);
    return Stack(
      children: [
        Positioned.fill(
            top: -ImageOffsettop,
            left: -ImageOffsetleft,
            child: Image.asset(
              onboarding.imageUrl,
              fit: BoxFit.cover,
              width: Responsive.screenWidth! +
                  Responsive.getResponsiveFontSize(context,
                      fontSize: ImageOffsetleft),
            )),
        Visibility(
          visible: showSkipButton,
          child: Positioned(
              top: Responsive.getResponsiveFontSize(context, fontSize: 20),
              right: Responsive.getResponsiveFontSize(context,fontSize: 10,
              ),
              child: _buildSkipButton(context)),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _buildOnboardingContent(context, onboarding, currentpage),
        ),
      ],
    );
  }
}


Widget _buildSkipButton(BuildContext context) {
  return InkWell(
    onTap: () {
      
      SharedPreferenceService.setbool(PrefsKeys.firstOpen, true);
      goToLogin();
     
    },
    child: Container(
      width: Responsive.getResponsiveFontSize(context, fontSize: 70),
      height: Responsive.getResponsiveFontSize(context, fontSize: 36),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(
            Responsive.getResponsiveFontSize(context, fontSize: 15)),
      ),
      alignment: Alignment.topRight,
      child: Center(
        child: Text(
          "Skip",
          style: TextStyle(
              fontSize:
                  Responsive.getResponsiveFontSize(context, fontSize: 15)),
        ),
      ),
    ),
  );
}

Widget _buildOnboardingContent(
    BuildContext context, OnboardingModel onboarding, int currentpage) {
  return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
                horizontal:
                    Responsive.getResponsiveFontSize(context, fontSize: 20),
                vertical:
                    Responsive.getResponsivebyHeigth(context, fontSize: 10))
            .copyWith(
                bottom:
                    Responsive.getResponsiveFontSize(context, fontSize: 30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              onboarding.title,
              style: TextStyle(
                color:AppColor.secondaryColor,
                fontSize:
                    Responsive.getResponsiveFontSize(context, fontSize: 24),
                fontFamily: GoogleFonts.outfit().fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: Responsive.getResponsiveFontSize(context,
                          fontSize: 10),
                      vertical: Responsive.getResponsivebyHeigth(context,
                          fontSize: 20))
                  .copyWith(
                      bottom: Responsive.getResponsivebyHeigth(context,
                          fontSize: 20)),
              child: Text(
                onboarding.body,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:
                      Responsive.getResponsiveFontSize(context, fontSize: 15),
                  fontFamily: GoogleFonts.outfit().fontFamily,
                  fontWeight: FontWeight.w400,
                  color: AppColor.lightGrey,
                ),
              ),
            ),
            DotsIndicator(
              dotsCount: 3,
              position: currentpage,
              decorator: DotsDecorator(
                size: Size.square(
                    Responsive.getResponsiveFontSize(context, fontSize: 12)),
                activeSize: Size.square(
                    Responsive.getResponsiveFontSize(context, fontSize: 12)),
                color: AppColor.dotColor,
                activeColor:AppColor.dotactiveColor
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: Responsive.getResponsivebyHeigth(context, fontSize: 30)),
              child: CustomButton(
                TextColor: Colors.black,
                text: "Sign in",
                onPressed: () {
                  SharedPreferenceService.setbool(PrefsKeys.firstOpen, true);
                  goToLogin();
                  
                },
              ),
            ),
          ],
        ),
      ));
}
goToLogin() => navigationService.replace(LoginView.route);
