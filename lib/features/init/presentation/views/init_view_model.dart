
import 'package:eram_express_shared/data/configurations/repositories/configurations_repository.dart';
import 'package:eram_express_shared/notification_service.dart';
import 'package:eram_express_shared/service_locator.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication/data/respositories/authentication_repository.dart';

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
       sl< NotificationService>().init(),
      //_configurationsRepository.getCountries(),
      _authenticationRepository.isAuthenticated, 
    ]);

    final isAuthenticated = results[1] as bool;
    if (isAuthenticated)
     {
      emit(true);
      return;
    }

    emit(false);
  }

 
}
