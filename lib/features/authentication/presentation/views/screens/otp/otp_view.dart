import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/presentation/widgets/clickable.dart';
import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../app/di.dart';
import '../../../../domain/objects/login_form_data.dart';
import 'otp_view_model.dart';
import 'otp_view_state.dart';

class OtpView extends StatelessWidget {
  static const String route = '/otp';

  final OtpViewArguments arguments;
  final OtpViewModel viewModel =
      OtpViewModel(authenticationService: authenticationService);

  OtpView(this.arguments, {super.key}) {
    viewModel.init(phoneNumber: arguments.loginFormData.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _buildPin(),
              const Gap(30),
              _buildVerifyButton(context),
            ],
          ),
        ),
      ),
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
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildHeading(BuildContext context) {
    return Row(
      children: [
        Text(
          context.t('otp.heading'),
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

  Widget _buildPin() {
    return BlocBuilder<OtpViewModel, OtpViewState>(
      bloc: viewModel,
      builder: (_, state) {
        return Pinput(
          enabled: state.pinEnabled,
          onChanged: viewModel.onOtpChanged,
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

  Widget _buildSubheading(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: context.t('otp.subheading'),
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
    return BlocBuilder<OtpViewModel, OtpViewState>(
      bloc: viewModel,
      builder: (_, state) {
        return CustomButton(
          enabled: state.verifyButtonEnabled,
          loading: state.verifyButtonLoading,
          onTap: viewModel.verifyButtonOnClicked,
          child: Text(
            context.t('otp.verify'),
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
