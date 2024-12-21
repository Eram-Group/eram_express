import 'package:eram_express/features/profile/presentation/widgets/customappbar.widgets.dart';
import 'package:eram_express_shared/core/api/server_expection.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/presentation/views/modals/error_modal.dart';
import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:eram_express_shared/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../Common/widgets/custom_text_field.dart';
import '../../../authentication/presentation/views/screens/complete_profile/complete_profile_view.dart';
import '../../../customer/data/models/customer_model.dart';
import 'edit_profile_view_model.dart';
import 'edit_profile_view_state.dart';
import 'profile_presentation/profile_view.dart';

class EditProfileViewArguments {
  final CustomerModel currentCustomer;

  const EditProfileViewArguments({
    required this.currentCustomer,
  });
}

class EditProfileView extends StatelessWidget {
  static const String route = "/Editprofile";
  final EditProfileViewArguments arguments;

  EditProfileView(this.arguments, {super.key}) {}

  Widget _buildProfilePicture(BuildContext context) {
    EditProfileViewModel viewModel = context.read<EditProfileViewModel>();
    return BlocBuilder<EditProfileViewModel, EditProfileViewState>(
        bloc: viewModel,
        builder: (context, state) {
          return ProfilePictureWidget(
            profilePictureUrl: state.profilePicture,
            profilePictureFile: state.profilePictureFile,
            onProfilePictureClick: viewModel.profilePictureOnClicked(context),
            saveButtonLoading: state.saving,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileViewModel>(
      create: (context) => sl()..setInitialValues(arguments),
      child: BlocListener<EditProfileViewModel, EditProfileViewState>(
        listener: (context, state) {
          if (state.isSuccess) {
            {
              Navigator.of(context).pushNamed(ProfileView.route);
            }
          } else if (state.isError) {
            ErrorModal.fromApiError(state.serverException!).show(context);
          }
        },
        child: Builder(builder: (context) {
          return Scaffold(
            appBar:
                CustomAppBar(title: context.tt("Edit Profile", "تعديل الحساب")),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16)
                  .copyWith(bottom: 0),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: _buildProfilePicture(context),
                        ),
                        const Gap(30),
                        _buildTitleField(
                          context.tt('full name', 'الاسم بالكامل'),
                        ),
                        BlocBuilder<EditProfileViewModel, EditProfileViewState>(
                            builder: (context, state) {
                          return CustomTextField(
                            hintText: context.tt(
                                'Enter your full name', 'ادخل اسمك الكامل'),
                            onChanged: (string) {
                              context
                                  .read<EditProfileViewModel>()
                                  .onFullNameChanged(string);
                            },
                            initialValue: state.fullName,
                          );
                        }),
                        const Gap(30),
                        _buildTitleField(
                            context.tt('Phone Number', 'رقم التليفون')),
                        BlocBuilder<EditProfileViewModel, EditProfileViewState>(
                            builder: (context, state) {
                          return CustomTextField(
                            onChanged: (string) {},
                            initialValue: state.phoneNumber!,
                            isEnabled: false,
                          );
                        }),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child:
                        BlocBuilder<EditProfileViewModel, EditProfileViewState>(
                            builder: (context, state) {
                      logger.debug(state.isLoading.toString());
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomButton(
                            loading: state.isLoading,
                            enabled: context
                                .read<EditProfileViewModel>()
                                .enabledButton(),
                            onTap: () {
                              context
                                  .read<EditProfileViewModel>()
                                  .saveButtonOnClicked(context);
                            },
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
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

Widget _buildTitleField(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text(
      title,
      style: const TextStyle(
        color: Color(0xFF191D31),
        fontFamily: 'Outfit',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
    ),
  );
}
