import 'package:eram_express/features/profile/presentation/views/profile_presentation/profile_view_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../authentication/data/respositories/authentication_repository.dart';

import '../edit_profile_view.dart';

class ProfileViewModel extends Cubit<ProfileViewState> {
  final AuthenticationRepository _authenticationRepository;
  ProfileViewModel({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(ProfileViewState(status: ProfileStatus.initial));

  void getCustomerData() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final currentCustomer =
        await _authenticationRepository.authenticatedCustomer;
    emit(state.copyWith(currentCustomer: currentCustomer));
  }

  void editProfileClickable(BuildContext context) async {
    Navigator.of(context).pushNamed(EditProfileView.route,
        arguments:
            EditProfileViewArguments(currentCustomer: state.currentCustomer!));
  }

  void logout() async {
    try {
      await _authenticationRepository.logout();
      emit(state.copyWith(status: ProfileStatus.logout, currentCustomer: null));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.error));
    }
  }
}
