import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  void changeLocale(Locale locale) => emit(locale);

  void toArabic() => changeLocale(const Locale('ar'));
  void toEnglish() => changeLocale(const Locale('en'));
}
