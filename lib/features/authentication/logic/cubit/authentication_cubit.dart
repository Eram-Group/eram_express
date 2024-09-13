import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';
import '../repositories/authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(AuthenticationInitial());

  void authenticate({
    required String username,
  }) async {
    emit(AuthenticationLoading());

    final user =
        await _authenticationRepository.authenticate(username: username);

    user.fold(
      (error) => emit(AuthenticationFailure(message: error)),
      (user) => emit(AuthenticationSuccess(user: user)),
    );
  }
}
