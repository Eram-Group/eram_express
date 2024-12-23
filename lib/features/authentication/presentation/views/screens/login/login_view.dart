import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eram_express_shared/core/api/server_expection.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/presentation/views/modals/error_modal.dart';
import 'package:eram_express_shared/presentation/widgets/clickable.dart';
import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:eram_express_shared/presentation/widgets/skeleton.dart';
import 'package:eram_express_shared/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../objects/login_form_data.dart';
import '../otp/otp_view.dart';
import 'login_view_state.dart';
import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  static const String route = '/login';

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginViewModel>()..init(),
      child: Builder(builder: (context) {
        return BlocListener<LoginViewModel, LoginViewState>(
          listenWhen: (currentState, previousState) =>
              currentState.status != previousState.status,
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.of(context).pushNamed(
                OtpView.route,
                arguments: OtpViewArguments(
                  loginFormData: LoginFormData(
                    phoneNumber: state.phoneNumber!,
                  ),
                ),
              );
            } else if (state.isError) {
              ErrorModal.fromApiError(state.serverException!).show(context);
            }
          },
          child: Scaffold(
            body: Stack(
              children: [
                _buildBackground(),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildBottomSheet(
                    context,
                    child: _buildBody(context),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildContent(context),
        const Gap(30),
        _buildForm(context),
      ],
    );
  }

  Widget _buildBottomSheet(
    context, {
    required Widget child,
  }) {
    return ClipRect(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 255, 255, 0),
              Color.fromRGBO(255, 255, 255, 0.41),
            ],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeading(context),
        const Gap(10),
        _buildSubheading(context),
      ],
    );
  }

  Widget _buildCountryCodeButton(BuildContext context) {
    final viewModel = context.read<LoginViewModel>();
    return BlocBuilder<LoginViewModel, LoginViewState>(
      bloc: viewModel,
      builder: (_, state) {
        return Opacity(
          opacity: !state.isLoading ? 1 : 0.5,
          child: Clickable(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            onTap: () => viewModel.countryCodeButtonOnClicked(context),
            child: Row(
              children: [
                if (state.selectedCountry != null)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          state.selectedCountry!.flag,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  const Skeleton(
                    width: 24,
                    height: 18,
                    shape: BoxShape.circle,
                  ),
                const Gap(8),
                if (state.selectedCountry != null)
                  Text(
                    state.selectedCountry!.phoneCode,
                    style: const TextStyle(
                      color: Color(0xFF191D31),
                      fontFamily: 'Outfit',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 25.2 / 14,
                    ),
                    textAlign: TextAlign.left,
                  )
                else
                  const Skeleton(width: 40, height: 16),
                const Gap(8),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF64748B),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldTitle({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'Outfit',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 15.6 / 12,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      children: [
        _buildPhoneNumberSection(context),
        const Gap(20),
        _buildLoginButton(context),
      ],
    );
  }

  Widget _buildHeading(BuildContext context) {
    return Text(
      context.tt('Login', 'تسجيل الدخول'),
      style: const TextStyle(
        color: Color(0xFFFDBC58),
        fontFamily: 'Outfit',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 26 / 20,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    final viewModel = context.read<LoginViewModel>();
    return BlocBuilder<LoginViewModel, LoginViewState>(
      bloc: viewModel,
      builder: (_, state) => CustomButton(
        enabled: viewModel.enabledButton(),
        loading: state.isLoading,
        onTap: () => viewModel.loginButtonOnClicked(context),
        child: Text(
          context.tt('Login', 'تسجيل الدخول'),
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Outfit',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 19.2 / 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFF3F3F3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _buildCountryCodeButton(context),
          _buildSeparator(),
          const Gap(7),
          Expanded(
            child: _buildPhoneNumberTextField(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildFieldTitle(title: context.tt('Phone Number', 'رقم الهاتف')),
        const Gap(3),
        _buildPhoneNumberField(context),
      ],
    );
  }

  Widget _buildPhoneNumberTextField(BuildContext context) {
    final viewModel = context.read<LoginViewModel>();
    return BlocBuilder<LoginViewModel, LoginViewState>(
      bloc: viewModel,
      builder: (_, state) {
        return TextFormField(
          enabled: viewModel.phoneNumberFieldEnabled(),
          keyboardType: TextInputType.phone,
          inputFormatters: [
            if (state.selectedCountry != null)
              state.selectedCountry!.numberFormat
          ],
          decoration: InputDecoration(
            hintText: context.tt(
              'Enter your phone number',
              'ادخل رقم هاتفك',
            ),
            hintStyle: const TextStyle(
              color: Color(0xFFA7A9B7),
              fontFamily: 'Outfit',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 25.2 / 14,
            ),
            border: InputBorder.none,
          ),
          initialValue: state.phoneNumber,
          onChanged: (value) => viewModel.phoneNumberChanged(value),
        );
      },
    );
  }

  Widget _buildSeparator() {
    return Container(
      width: 1,
      height: 24,
      color: const Color(0xFFF1F5F9),
    );
  }

  Widget _buildSubheading(BuildContext context) {
    return Text(
      context.tt(
        'Enter your phone number to receive a verification code',
        'ادخل رقم هاتفك لتتلقى رمز التحقق',
      ),
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'Outfit',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 25.2 / 14,
      ),
      textAlign: TextAlign.left,
    );
  }
}
