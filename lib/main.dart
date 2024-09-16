import 'package:eram_express/core/Services/Shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'app/di.dart';

void main()  async
{
WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceService.init();

 runApp(
      MultiBlocProvider(
        providers: container,
        child: const App(),
      ),
    );
}
