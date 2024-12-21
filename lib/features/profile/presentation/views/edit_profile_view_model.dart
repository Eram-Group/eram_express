import 'dart:io';
import 'package:eram_express/features/customer/data/services/customer_service.dart';
import 'package:eram_express_shared/core/api/server_expection.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/presentation/views/modals/image_picker_modal/image_picker_modal.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication/data/respositories/authentication_repository.dart';
import '../../../customer/data/objects/update_customer_form_data.dart';
import 'edit_profile_view.dart';
import 'edit_profile_view_state.dart';

class EditProfileViewModel extends Cubit<EditProfileViewState> {
  final CustomerService _customerService;
  final AuthenticationRepository _authenticationRepository;

  String username = "";
  String image = " ";
  EditProfileViewModel({
    required CustomerService customerService,
    required AuthenticationRepository authenticationRepository,
  })  : _customerService = customerService,
        _authenticationRepository = authenticationRepository,
        super(const EditProfileViewState(status: EditProfileStatus.initial)) {}

  void setInitialValues(EditProfileViewArguments arguments) {
    username = arguments.currentCustomer.fullName;
    logger.debug(arguments.currentCustomer.image.toString());
    if (arguments.currentCustomer.image != null) {
      image = arguments.currentCustomer.image!;
    }
    logger.debug(image.toString());
    emit(state.copyWith(
      fullName: arguments.currentCustomer.fullName,
      phoneNumber: arguments.currentCustomer.phoneNumber,
      profilePicture: arguments.currentCustomer.image,
    ));
  }

  void onFullNameChanged(String fullName) {
    emit(state.copyWith(status: EditProfileStatus.loaded, fullName: fullName));
  }

  void onPictureChanged(String profilePicture) {
    emit(state.copyWith(
        status: EditProfileStatus.loaded, profilePicture: profilePicture));
  }

  void Function()? profilePictureOnClicked(BuildContext context) =>
      () => _profilePictureOnClicked(context);

  void _profilePictureOnClicked(BuildContext context) =>
      ImagePickerModal(onImagePicked: _profilePictureOnPicked).show(context);

  void _profilePictureOnPicked(File pickedImage) {
    logger.debug('Profile picture on picked called');
    logger.debug(pickedImage.toString());
    emit(state.copyWith(
        status: EditProfileStatus.loaded, profilePictureFile: pickedImage));
  }

  bool enabledButton() {
    return (state.fullName != username ||
        (state.profilePictureFile != null &&
            state.profilePictureFile!.path != image));
  }

  Future<void> saveButtonOnClicked(BuildContext context) async {
    try {
      emit(state.copyWith(status: EditProfileStatus.loading));
    
      final response = await _customerService.updateProfile(
        data: UpdateCustomerFormData(
            fullName: state.fullName, profilePicture: state.profilePictureFile),
      );

      _authenticationRepository.updateAuthenticatedCustomer(response);
      emit(state.copyWith(status: EditProfileStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: EditProfileStatus.error,
          serverException: e as ServerException));
    }
  }
}
