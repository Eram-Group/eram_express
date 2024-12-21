import 'package:eram_express_shared/data/configurations/repositories/configurations_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication/data/respositories/authentication_repository.dart';

class InitViewModel extends Cubit<bool> {
  final AuthenticationRepository _authenticationRepository;

  InitViewModel({
    required AuthenticationRepository authenticationRepository,
    required ConfigurationsRepository configurationsRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(false);

  Future<void> init() async {
    final results = await Future.wait([
      _authenticationRepository.isAuthenticated(),
    ]);

    final isAuthenticated = results[0];
    if (isAuthenticated) {
      emit(true);
    } else {
      emit(false);
    }
  }
}
