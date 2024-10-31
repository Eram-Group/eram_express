import 'package:eram_express/app/app.dart';
import 'package:eram_express/app/di.dart';
import 'package:eram_express/features/customer/domain/entities/customer_entity.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../app/navigation.dart';
import '../../../Common/widgets/custom_text_field.dart';
import 'edit_profile_view_model.dart';
import 'edit_profile_view_state.dart';
import 'profile_presentation/profile_view_model.dart';

class EditProfileViewArguments {
  final CustomerEntity currentCustomer;

  const EditProfileViewArguments({
    required this.currentCustomer,
  });
}

class EditProfileView extends StatelessWidget {
  static const String route = "/Editprofile";
  final EditProfileViewArguments arguments;
  final EditProfileViewModel viewmodel =
      EditProfileViewModel(customerService: customerService);
  EditProfileView(this.arguments, {super.key}) {
    viewmodel.setInitialValues(arguments);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16)
            .copyWith(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleField(
              context.tt('full name', 'الاسم بالكامل'),
            ),
            BlocBuilder<EditProfileViewModel, EditProfileViewState>(
                bloc: viewmodel,
                builder: (context, state) {
                  return CustomTextField(
                    hintText:
                        context.tt('Enter your full name', 'ادخل اسمك الكامل'),
                    onChanged: (string) {
                      viewmodel.onFullNameChanged(string);
                    },

                    //initialValue: state.fullName,
                  );
                }),
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
            const Spacer(),
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
                })
          ],
        ),
      ),
    );
  }
}

/*
Widget _buildFullNameField(BuildContext context, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Color(0xFF191D31),
          fontFamily: 'Outfit',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.3,
        ),
      ),
      Gap(3),
      /*
      BlocBuilder<CompleteProfileViewModel, CompleteProfileViewState>(
        bloc: viewModel,
        builder:
         (context, state) {
         */
      CustomTextField(
        hintText: NavigationService.globalContext
            .tt('Enter your full name', 'ادخل اسمك الكامل'),
        onChanged: (string) {},
      ),
    ],
  );
}
*/
Widget _buildTitleField(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: Color(0xFF191D31),
      fontFamily: 'Outfit',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
  );
}
