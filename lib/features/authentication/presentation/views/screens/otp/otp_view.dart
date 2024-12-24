import 'package:eram_express/app/service_locator.dart';
import 'package:eram_express/features/nav_bar/bottom_nav_bar.view.dart';
import 'package:eram_express_shared/core/api/server_expection.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/presentation/views/modals/error_modal.dart';
import 'package:eram_express_shared/presentation/widgets/clickable.dart';
import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:eram_express_shared/service_locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import '../../../../../home/presentation/views/home_view.dart';
import '../../../objects/login_form_data.dart';
import '../complete_profile/complete_profile_view.dart';
import 'otp_view_model.dart';
import 'otp_view_state.dart';

class OtpView extends StatelessWidget {
  static const String route = '/otp';

  final OtpViewArguments arguments;

  const OtpView(this.arguments, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OtpViewModel>()
        ..init(phoneNumber: arguments.loginFormData.phoneNumber),
      child: Builder(builder: (context) {
        return BlocListener<OtpViewModel, OtpViewState>(
          listener: (context, state) {
            if (state.isError) {
              ErrorModal.fromApiError(state.serverException!).show(context);
            } else if (state.isSuccess) {
              if (state.isNewCustomer!) {
                Navigator.of(context).pushNamedAndRemoveUntil(CompleteProfileView.route,
                  (route) => false,
                );
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  NavigationView.route,
                  (route) => false,
                );
              }
            } else if (state.isError) {
              ErrorModal.fromApiError(state.serverException!).show(context);
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildTopBar(context),
                    const Gap(24),
                    _buildHeading(context),
                    const Gap(10),
                    _buildSubheading(context),
                    const Gap(30),
                    _buildPin(context),
                    const Gap(30),
                    _buildVerifyButton(context),
                    const Gap(30),
                    _buildResendOtp(context),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Clickable(
      padding: const EdgeInsets.all(12),
      splashColor: Colors.black.withOpacity(0.1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFF3F3F3),
          width: 1.0,
        ),
      ),
      child: const Icon(Icons.arrow_back),
      onTap: () {
        Navigator.of(context).pop(); // المشكله  لما بيرجع بيكون محتفظ بال state =success
      },
    );
  }

  Widget _buildHeading(BuildContext context) {
    return Row(
      children: [
        Text(
          context.tt('Verify your phone number', 'تحقق من رقم هاتفك'),
          style: const TextStyle(
            color: Color(0xFF3FAD79),
            fontFamily: 'Outfit',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.3,
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
      ],
    );
  }

  Widget _buildPin(BuildContext context) {
    final viewModel = context.read<OtpViewModel>();
    return BlocBuilder<OtpViewModel, OtpViewState>(
      builder: (_, state) {
        
        return Pinput(
          enabled: state.isTiming,
          onChanged: viewModel.onOtpChanged(),
          separatorBuilder: (index) => const Gap(21),
          autofocus: true,
          cursor: Container(
            width: 1.5,
            height: 22,
            decoration: const BoxDecoration(
              color: Color(0xFFFFC96E),
            ),
          ),
          defaultPinTheme: _pinTheme(),
          focusedPinTheme: _pinTheme().copyDecorationWith(
            border: Border.all(
              color: const Color(0xFF194595),
              width: 1,
            ),
          ),
        );
      },
    );
  }

  Widget _buildResendOtp(BuildContext context) {
    final viewModel = context.read<OtpViewModel>();
    return BlocBuilder<OtpViewModel, OtpViewState>(
      builder: (_, state) {
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text:context.tt('Didn\'t receive the code?', 'لم تستلم الرمز؟'),
                style: const TextStyle(
                  color: Color(0xFFA7A9B7),
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.8,
                ),
              ),
              const TextSpan(
                text: ' ',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.8,
                ),
              ),
              TextSpan(
                text: viewModel.resendButtonEnabled()
                    ? context.tt('Resend', 'إعادة الإرسال')
                    : '${context.tt('Resend in', 'إعادة الإرسال في')} ${state.canResendIn} ${context.tt('seconds', 'ثواني')}',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.8,
                  color: const Color(0xFF194595).withOpacity(
                    viewModel.resendButtonEnabled() ? 1 : 0.5,
                  ),
                ),
                recognizer: viewModel.resendButtonEnabled()
                    ? (TapGestureRecognizer()
                      ..onTap = () => viewModel.resendOtpOnClicked())
                    : null,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildSubheading(BuildContext context) {
    final viewModel = context.read<OtpViewModel>();
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: context.tt(
              'Enter the code sent to',
              'أدخل الرمز المرسل إلى',
            ),
            style: const TextStyle(
              color: Color(0xFFA7A9B7),
              fontFamily: 'Outfit',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.8,
            ),
          ),
          const TextSpan(
            text: ' ',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.8,
            ),
          ),
          TextSpan(
            text: viewModel.phoneNumber,
            style: const TextStyle(
              fontFamily: 'Outfit',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.3,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBackButton(context),
      ],
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    final viewModel = context.read<OtpViewModel>();
    return BlocBuilder<OtpViewModel, OtpViewState>(
      builder: (_, state) {
        return CustomButton(
          enabled: state.otp!.length == 4,  // هو صلح اني اعمل check كده؟؟
          loading: state.isLoading,
          onTap: () => viewModel.verifyButtonOnClicked(context),
          child: Text(
            context.tt('Verify', 'تحقق'),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Outfit',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        );
      },
    );
  }

  PinTheme _pinTheme() {
    return PinTheme(
      width: 66,
      height: 59,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontFamily: 'Outfit',
        fontSize: 22,
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
    );
  }
}

class OtpViewArguments {
  final LoginFormData loginFormData;

  const OtpViewArguments({
    required this.loginFormData,
  });
}
