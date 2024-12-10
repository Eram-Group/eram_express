import 'package:eram_express/app/ServiceLocator.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/presentation/widgets/clickable.dart';
import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../../../app/iconsax_icons.dart';
import '../../../../../customer/data/services/customer_service.dart';
import 'complete_profile_view_model.dart';
import 'complete_profile_view_state.dart';

class CompleteProfileView extends StatelessWidget {
  static const String route = '/complete-profile';
  final CompleteProfileViewModel viewModel =
      CompleteProfileViewModel(customerService: sl<CustomerService>());

  CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Gap(24),
              _buildHeading(context),
              const Gap(30),
              _buildProfilePicture(context),
              const Gap(30),
              _buildFullNameField(context),
              const Gap(30),
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFullNameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tt('Full Name', 'الاسم الكامل'),
          style: const TextStyle(
            color: Color(0xFF191D31),
            fontFamily: 'Outfit',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
        ),
        const Gap(3),
        BlocBuilder<CompleteProfileViewModel, CompleteProfileViewState>(
          bloc: viewModel,
          builder: (context, state) {
            return TextField(
              onChanged: viewModel.onFullNameChanged(),
              decoration: InputDecoration(
                hintText:
                    context.tt('Enter your full name', 'ادخل اسمك الكامل'),
                hintStyle: const TextStyle(
                  color: Color(0xFFB0B0B0),
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.8,
                ),
                enabled: !state.saving,
                border: _textFieldBorder(),
                enabledBorder: _textFieldBorder(),
                focusedBorder: _textFieldBorder(
                  color: const Color(0xFF194595),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  InputBorder _textFieldBorder({
    Color color = const Color(0xFFF3F3F3),
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _buildHeading(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.tt('Complete Profile', 'اكمل ملفك الشخصى'),
          style: const TextStyle(
            color: Color(0xFF3FAD79),
            fontFamily: 'Outfit',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.3,
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
        Clickable(
          onTap: () => Navigator.of(context).pop(),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            context.tt('Skip', 'تخطى'),
            style: const TextStyle(
              color: Color(0xFF194595),
              fontFamily: 'Outfit',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProfilePicture(BuildContext context) {
    return BlocBuilder<CompleteProfileViewModel, CompleteProfileViewState>(
      bloc: viewModel,
      builder: (context, state) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 89,
              height: 89,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEEF1F8),
                image: state.profilePicture == null
                    ? null
                    : DecorationImage(
                        image: Image.file(state.profilePicture!).image,
                        fit: BoxFit.cover,
                      ),
              ),
              child: state.profilePicture != null
                  ? null
                  : Center(
                      child: SvgPicture.asset(
                        'assets/icons/user.svg',
                      ),
                    ),
            ),
            Positioned(
              bottom: -10,
              right: -10,
              child: Clickable(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: state.saveButtonLoading
                      ? const Color.fromARGB(255, 105, 129, 176)
                      : const Color(0xFF194595),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                ),
                onTap: viewModel.profilePictureOnClicked(context),
                child: Center(
                  child: Icon(
                    Iconsax.camera,
                    color: state.saveButtonLoading
                        ? Colors.white.withOpacity(0.5)
                        : Colors.white,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return BlocBuilder<CompleteProfileViewModel, CompleteProfileViewState>(
      bloc: viewModel,
      builder: (_, state) {
        return CustomButton(
          enabled: state.saveButtonEnabled,
          loading: state.saveButtonLoading,
          onTap: viewModel.saveButtonOnClicked(context),
          child: Text(
            context.tt('Save', 'حفظ'),
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
}
