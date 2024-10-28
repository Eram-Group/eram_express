import 'package:eram_express/app/di.dart';
import 'package:eram_express/features/customer/domain/services/customer_service.dart';
import 'package:eram_express/features/profile/presentation/views/profile_presentation/profile_view.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/presentation/views/modals/error_modal.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../customer/domain/objects/update_customer_form_data.dart';
import 'edit_profile_view.dart';
import 'edit_profile_view_state.dart';

class EditProfileViewModel extends Cubit<EditProfileViewState> {
  final CustomerService _customerService;

  EditProfileViewModel({required CustomerService customerService})
      : _customerService = customerService,
        super(EditProfileViewState()) {
    //saveCustomerData();
  }

  void setInitialValues(EditProfileViewArguments arguments) {
    emit(state.copyWith(
      fullName: arguments.currentCustomer.fullName,
      phoneNumber: arguments.currentCustomer.phoneNumber,
      profilePicture: arguments.currentCustomer.image,
    ));
  }

  void onFullNameChanged(String fullName) {
    emit(state.copyWith(fullName: fullName));
  }

  Future<void> saveButtonOnClicked(BuildContext context) async 
 {
    emit(state.copyWith(saving: false));
    final response = await _customerService.updateProfile(
      data: UpdateCustomerFormData(
        fullName: state.fullName,
        //profilePicture: state.profilePicture.
      ),
    );
       emit(state.copyWith(saving: true));
    response.fold(
      (error) => ErrorModal.fromApiError(error).show(context),
      (data) async {
        Navigator.of(context).pushNamed(ProfileView.route);
      },
    );
  }
}
