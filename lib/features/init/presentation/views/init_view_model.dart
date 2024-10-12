import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di.dart';
import '../../../authentication/domain/repositories/authentication_repository.dart';
import '../../../authentication/presentation/views/screens/login/login_view.dart';
import '../../../home/presentation/views/home_view.dart';

class InitViewModel extends Cubit<bool> {
  final AuthenticationRepository _authenticationRepository;
  InitViewModel({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(false);

  Future<void> init() async {
    final isAuthenticated = await _authenticationRepository.isAuthenticated;
    if (!isAuthenticated) { // ععكسناهم علشان عايزه الهوم
      emit(true);
      mainNavigationService.clearStackAndNavigateTo(HomeView.route);
    } else {
      emit(false);
      mainNavigationService.clearStackAndNavigateTo(LoginView.route);
    }
  }
}
