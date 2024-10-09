import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/i18n/context_extension.dart';
import '../../../common/presentation/widgets/clickable.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  static const String route = '/login';

  final LoginViewModel viewModel = LoginViewModel();
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomSheet(context, child: _buildBody(context)),
          ),
        ],
      ),
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

  Widget _buildCountryCodeButton() {
    return Clickable(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
            ),
          ),
          const Gap(8),
          const Text(
            '+966',
            style: TextStyle(
              color: Color(0xFF191D31),
              fontFamily: 'Outfit',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 25.2 / 14,
            ),
            textAlign: TextAlign.left,
          ),
          const Gap(8),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF64748B),
          ),
        ],
      ),
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
      context.translate('login.heading'),
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
    return Clickable(
      width: double.infinity,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF424BB3),
        borderRadius: BorderRadius.circular(10),
      ),
      splashColor: const Color(0xFF424BB3).withOpacity(0.5),
      onTap: () => viewModel.loginButtonOnClicked(),
      child: Center(
        child: Text(
          context.translate('login.login'),
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
          _buildCountryCodeButton(),
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
        _buildFieldTitle(title: context.translate('login.phoneNumber')),
        const Gap(3),
        _buildPhoneNumberField(context),
      ],
    );
  }

  Widget _buildPhoneNumberTextField(BuildContext context) {
    return BlocBuilder<LoginViewModel, LoginFormState>(
      bloc: viewModel,
      builder: (_, state) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: context.translate('login.phoneNumberPlaceholder'),
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
      context.translate('login.subheading'),
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
