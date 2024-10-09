import 'package:flutter/material.dart';

import 'app_localizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const AppLocalizationsDelegate();

  List<Locale> get supportedLanguages => [
        const Locale('en'),
        const Locale('ar'),
      ];

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return supportedLanguages.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
