import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'app/di.dart';

void main() => runApp(
      MultiBlocProvider(
        providers: container,
        child: const App(),
      ),
    );
