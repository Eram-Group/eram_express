import 'package:eram_express/features/onboarding/data/onboarding_model.dart';
import 'package:eram_express/features/onboarding/logic/cubit/onboarding_cubit.dart';
import 'package:eram_express/features/onboarding/presentation/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Onboardingview extends StatelessWidget {
  static const route = '/onboarding';
  const Onboardingview({super.key});
  @override
  Widget build(BuildContext context) {
    List<OnboardingModel> OnBoardingList = [
      OnboardingModel(
          imageUrl:'assets/onboarding1.png',
          title: "Cash on Delivery or E-payment",
          body:
              "Our delivery will ensure your items are delivered right to the door steps"),
      OnboardingModel(
          imageUrl: "assets/onboadring2.png",
          title: "Cash on Delivery or E-payment",
          body:
              "Our delivery will ensure your items are delivered right to the door steps"),
      OnboardingModel(
          imageUrl: "assets/onboarding3.png",
          title: "Delivery Right to Your Door Step",
          body:
              'Our delivery will ensure your items are delivered right to the door steps'),
    ];

    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: BlocSelector<OnboardingCubit, int, bool>(
            selector: (state) => state != 2,
            builder: (context, showSkipButton) {
              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (index) {
                        context.read<OnboardingCubit>().setPage(index);
                      },
                      itemCount: OnBoardingList.length,
                      itemBuilder: (context, i) => OnBoarding_body(
                        showSkipButton: showSkipButton,
                        onboarding: OnBoardingList[i],
                        currentpage: i,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
