import 'dart:io';

import 'package:eram_express/app/di.dart';
import 'package:eram_express/features/customer/domain/services/customer_service.dart';
import 'package:eram_express/features/profile/presentation/views/profile_presentation/profile_view.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/presentation/views/modals/error_modal.dart';
import 'package:eram_express_shared/presentation/views/modals/image_picker_modal/image_picker_modal.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../customer/domain/objects/update_customer_form_data.dart';
import 'edit_profile_view.dart';
import 'edit_profile_view_state.dart';

class EditProfileViewModel extends Cubit<EditProfileViewState> {
  final CustomerService _customerService;
  String username = "";
  String? image;
  EditProfileViewModel({required CustomerService customerService})
      : _customerService = customerService,
        super(EditProfileViewState()) {}

  void setInitialValues(EditProfileViewArguments arguments) {
    username = arguments.currentCustomer.fullName;
    emit(state.copyWith(
      fullName: arguments.currentCustomer.fullName,
      phoneNumber: arguments.currentCustomer.phoneNumber,
      profilePicture: arguments.currentCustomer.image,
    ));
  }

  void onFullNameChanged(String fullName) {
    emit(state.copyWith(fullName: fullName));
  }

  void onPictureChanged(String profilePicture) {
    emit(state.copyWith(profilePicture: profilePicture));
  }

  void Function()? profilePictureOnClicked(BuildContext context) =>
      () => _profilePictureOnClicked(context);

  void _profilePictureOnClicked(BuildContext context) =>
      ImagePickerModal(onImagePicked: _profilePictureOnPicked).show(context);

  void _profilePictureOnPicked(File pickedImage) {
    logger.debug('Profile picture on picked called');
    emit(state.copyWith(profilePicture: pickedImage.path));
  }

  bool enabledbutton() {
    return state.fullName != username ? true : false;
  }

  Future<void> saveButtonOnClicked(BuildContext context) async {
    final response = await _customerService.updateProfile(
      data: UpdateCustomerFormData(
        fullName: state.fullName,
        //profilePicture: state.profilePicture.
      ),
    );

    response.fold(
      (error) => ErrorModal.fromApiError(error).show(context),
      (data) async {
        Navigator.of(context).pushNamed(ProfileView.route);
      },
    );
  }
}
