import 'package:equatable/equatable.dart';
import 'package:eram_express/core/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormState extends Equatable {
  final bool isLoading;
  final String phoneNumber;

  LoginFormState({
    required this.isLoading,
    required this.phoneNumber,
  }) {
    logger.debug('LoginFormState: $this');
  }

  factory LoginFormState.initial() =>
      LoginFormState(isLoading: false, phoneNumber: '');

  LoginFormState copyWith({
    bool? isLoading,
    String? phoneNumber,
  }) {
    return LoginFormState(
      isLoading: isLoading ?? this.isLoading,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [isLoading, phoneNumber];
}

class LoginViewModel extends Cubit<LoginFormState> {
  LoginViewModel() : super(LoginFormState.initial());

  void phoneNumberChanged(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void loginButtonOnClicked() async {
    emit(state.copyWith(isLoading: true));

    // TODO: Use authentication service to login
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(isLoading: false));
  }
}
