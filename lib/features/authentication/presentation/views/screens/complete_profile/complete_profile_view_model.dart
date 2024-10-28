import 'dart:io';

import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/presentation/views/modals/error_modal.dart';
import 'package:eram_express_shared/presentation/views/modals/image_picker_modal/image_picker_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../customer/domain/objects/update_customer_form_data.dart';
import '../../../../../customer/domain/services/customer_service.dart';
import '../../modals/registered_successfully_modal.dart';
import 'complete_profile_view_state.dart';

class CompleteProfileViewModel extends Cubit<CompleteProfileViewState> {
  final CustomerService _customerService;
  CompleteProfileViewModel({
    required CustomerService customerService,
  })  : _customerService = customerService,
        super(CompleteProfileViewState());

  void Function(String)? onFullNameChanged() =>
      state.fullNameEnabled ? _onFullNameChanged : null;

  void Function()? profilePictureOnClicked(BuildContext context) =>
      state.profilePictureEnabled
          ? () => _profilePictureOnClicked(context)
          : null;

  void Function()? saveButtonOnClicked(BuildContext context) =>
      state.saveButtonEnabled ? () => _saveButtonOnClicked(context) : null;

  void _onFullNameChanged(String fullName)
   {
    emit(state.copyWith(fullName: fullName));
  }

  void _profilePictureOnClicked(BuildContext context) =>
      ImagePickerModal(onImagePicked: _profilePictureOnPicked).show(context);

  void _profilePictureOnPicked(File pickedImage) {
    logger.debug('Profile picture on picked called');
    emit(state.copyWith(profilePicture: pickedImage));
  }

  Future<void> _saveButtonOnClicked(BuildContext context) async {
    emit(state.copyWith(saving: true));

    final response = await _customerService.updateProfile(
      data: UpdateCustomerFormData(
        fullName: state.fullName,
        profilePicture: state.profilePicture,
      ),
    );

    emit(state.copyWith(saving: false));

    response.fold(
      (error) => ErrorModal.fromApiError(error).show(context),
      (data) async {
        final navigator = Navigator.of(context);
        await const RegisteredSuccessfullyModal().show(context);
        navigator.pop();
      },
    );
  }
}
