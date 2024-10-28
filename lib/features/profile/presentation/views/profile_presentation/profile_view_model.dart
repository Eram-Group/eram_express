import 'package:eram_express/features/customer/domain/services/customer_service.dart';
import 'package:eram_express/features/profile/domain/repositories/profile_repository.dart';
import 'package:eram_express/features/profile/presentation/views/profile_presentation/profile_view_state.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/navigation.dart';
import '../../../../authentication/domain/repositories/authentication_repository.dart';
import '../../../../customer/domain/repositories/customer_repository.dart';
import '../edit_profile_view.dart';
import '../terms_presentation/terms_view_state.dart';

class ProfileViewModel extends Cubit<ProfileViewState> {
  final CustomerService _customerService;
  final AuthenticationRepository _authenticationRepository;
  ProfileViewModel(
      {required CustomerService customerservice,
      required AuthenticationRepository authenticationRepository})
      : _customerService = customerservice,
        _authenticationRepository = authenticationRepository,
        super(ProfileViewState())
        {
          getCustomerData();
        }

  void getCustomerData() async {
    logger.debug("enter to get dataaa");
    final currentcustomer =
        await _authenticationRepository.authenticatedCustomer;
    
    emit(state.copyWith(currentCustomer: currentcustomer));
  }

  void EditProfileClickable() async {
    Navigator.of(NavigationService.globalContext).pushNamed(
        EditProfileView.route,
        arguments:
            EditProfileViewArguments(currentCustomer: state.currentCustomer!));
  }
}
