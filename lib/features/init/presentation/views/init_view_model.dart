import 'package:eram_express_shared/notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication/data/respositories/authentication_repository.dart';

class InitViewModel extends Cubit<bool> {
  final AuthenticationRepository _authenticationRepository;
  final NotificationService _notificationService;

  InitViewModel({
    required AuthenticationRepository authenticationRepository,
    required NotificationService notificationService,
  })  : _authenticationRepository = authenticationRepository,
        _notificationService = notificationService,
        super(false);

  Future<void> init() async {
    final results = await Future.wait([
      _notificationService.init(),
      _authenticationRepository.isAuthenticated(),
    ]);

    final isAuthenticated = results[1] as bool;
    if (isAuthenticated) {
      emit(true);
      return;
    }

    emit(false);
  }
}
