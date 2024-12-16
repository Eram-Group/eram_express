import 'package:eram_express/features/customer/data/services/customer_service.dart';
import 'package:eram_express/features/profile/presentation/views/profile_presentation/profile_view_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/navigation.dart';
import '../../../../authentication/data/respositories/authentication_repository.dart';

import '../edit_profile_view.dart';

class ProfileViewModel extends Cubit<ProfileViewState> {
  final CustomerService _customerService;
  final AuthenticationRepository _authenticationRepository;
  ProfileViewModel(
      {required CustomerService customerservice,
      required AuthenticationRepository authenticationRepository})
      : _customerService = customerservice,
        _authenticationRepository = authenticationRepository,
        super(ProfileViewState());

  void getCustomerData() async 
  {
    final currentcustomer = await _authenticationRepository.authenticatedCustomer;
    emit(state.copyWith(currentCustomer: currentcustomer));
  }

  void EditProfileClickable() async 
  {
    Navigator.of(NavigationService.globalContext).pushNamed(
        EditProfileView.route,
        arguments:EditProfileViewArguments(currentCustomer: state.currentCustomer!));
  }
}
