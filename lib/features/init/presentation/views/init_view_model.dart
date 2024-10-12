import 'package:eram_express_shared/di.dart';
import 'package:eram_express_shared/domain/repositories/configurations_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/domain/repositories/authentication_repository.dart';
import '../../../authentication/presentation/views/screens/login/login_view.dart';
import '../../../home/presentation/views/home_view.dart';

class InitViewModel extends Cubit<bool> {
  final AuthenticationRepository _authenticationRepository;
  final ConfigurationsRepository _configurationsRepository;

  InitViewModel({
    required AuthenticationRepository authenticationRepository,
    required ConfigurationsRepository configurationsRepository,
  })  : _authenticationRepository = authenticationRepository,
        _configurationsRepository = configurationsRepository,
        super(false);

  Future<void> init() async {
    final results = await Future.wait([
      _configurationsRepository.countries,
      _authenticationRepository.isAuthenticated,
    ]);

    final isAuthenticated = results[1] as bool;

    if (isAuthenticated) {
      emit(true);
      mainNavigationService.clearStackAndNavigateTo(HomeView.route);
    } else {
      emit(false);
      mainNavigationService.clearStackAndNavigateTo(LoginView.route);
    }
  }
}
