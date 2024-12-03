import 'package:eram_express/app/app.dart';
import 'package:eram_express/app/di.dart';
import 'package:eram_express/features/profile/presentation/widgets/customappbar.widgets.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../app/navigation.dart';
import '../../../Common/widgets/custom_text_field.dart';
import '../../../authentication/presentation/views/screens/complete_profile/complete_profile_view.dart';
import '../../../customer/data/models/customer_model.dart';
import 'edit_profile_view_model.dart';
import 'edit_profile_view_state.dart';
import 'profile_presentation/profile_view_model.dart';

class EditProfileViewArguments {
  final CustomerModel currentCustomer;

  const EditProfileViewArguments({
    required this.currentCustomer,
  });
}

class EditProfileView extends StatelessWidget {
  static const String route = "/Editprofile";
  final EditProfileViewArguments arguments;
  final EditProfileViewModel viewmodel =
      EditProfileViewModel(customerService: customerService);
  EditProfileView(this.arguments, {super.key}) 
  {
    viewmodel.setInitialValues(arguments);
  }

  Widget _buildProfilePicture(BuildContext context) {
    return BlocBuilder<EditProfileViewModel, EditProfileViewState>(
        bloc: viewmodel,
        builder: (context, state) {
          return ProfilePictureWidget(
            profilePictureUrl: state.profilePicture,
            onProfilePictureClick: viewmodel.profilePictureOnClicked(context),
            saveButtonLoading: state.saving,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tt("Edit Profile", "تعديل الحساب")),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16)
            .copyWith(bottom: 0),
        child: CustomScrollView(
          slivers: [
            // المحتوى الرئيسي
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
                      bloc: viewmodel,
                      builder: (context, state) {
                        return CustomTextField(
                          hintText: context.tt(
                              'Enter your full name', 'ادخل اسمك الكامل'),
                          onChanged: (string) {
                            viewmodel.onFullNameChanged(string);
                          },
                          initialValue: state.fullName,
                        );
                      }),
                  const Gap(30),
                  _buildTitleField(context.tt('Phone Number', 'رقم التليفون')),
                  BlocBuilder<EditProfileViewModel, EditProfileViewState>(
                      bloc: viewmodel,
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
              child: BlocBuilder<EditProfileViewModel, EditProfileViewState>(
                  bloc: viewmodel,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                          enabled: viewmodel.enabledbutton(),
                          onTap: () {
                            logger.debug(viewmodel.state.fullName!);
                            viewmodel.saveButtonOnClicked(context);
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
  }
}

/*
 SliverFillRemaining(
                hasScrollBody: false,
                child: Expanded(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.end, // يضع المحتوى في النهاية
                    children: [
                      BlocBuilder<EditProfileViewModel, EditProfileViewState>(
                          bloc: viewmodel,
                          builder: (context, state) {
                            return CustomButton(
                              enabled: viewmodel.enabledbutton(),
                              onTap: () {
                                logger.debug(viewmodel.state.fullName!);
                                viewmodel.saveButtonOnClicked(context);
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
                            );
                          }),
                      const Gap(40),
                    ],
                  ),
                )),
          ],
        ),*/
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



/*
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tt("Edit Profile", "تعديل الحساب")),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16)
            .copyWith(bottom: 40),
        child: SingleChildScrollView(
          child:
           Column(
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
                  bloc: viewmodel,
                  builder: (context, state) {
                    return CustomTextField(
                      hintText: context.tt(
                          'Enter your full name', 'ادخل اسمك الكامل'),
                      onChanged: (string) {
                        viewmodel.onFullNameChanged(string);
                      },
                      initialValue: state.fullName,
                    );
                  }),
              const Gap(30),
              _buildTitleField(context.tt('Phone Number', 'رقم التليفون')),
              BlocBuilder<EditProfileViewModel, EditProfileViewState>(
                  bloc: viewmodel,
                  builder: (context, state) {
                    return CustomTextField(
                      onChanged: (string) {},
                      initialValue: state.phoneNumber!,
                      isEnabled: false,
                    );
                  }),
              //const Spacer(),

              BlocBuilder<EditProfileViewModel, EditProfileViewState>(
                  bloc: viewmodel,
                  builder: (context, state) {
                    return CustomButton(
                      enabled: viewmodel.enabledbutton(),
                      onTap: () {
                        logger.debug(viewmodel.state.fullName!);
                        viewmodel.saveButtonOnClicked(context);
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
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}*/