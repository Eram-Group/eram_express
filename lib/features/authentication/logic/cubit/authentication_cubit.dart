import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';

part 'authentication_state.dart';

class LoginScreenCubit extends Cubit<AuthenticationState> {
  LoginScreenCubit() : super(AuthenticationInitial());

  void loginButtonOnClicked({
    required String phoneNumber,
  }) async {
    emit(AuthenticationLoading());
  }
}
