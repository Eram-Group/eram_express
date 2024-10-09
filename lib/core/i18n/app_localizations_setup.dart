import 'package:eram_express/core/i18n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizationsSetup {
  static Iterable<LocalizationsDelegate> get delegates => [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ];

  static Iterable<Locale> get supportedLocales =>
      AppLocalizations.supportedLanguages;

  static Locale get defaultLocale => const Locale('en');

  static Locale? localeResolutionCallback(
    Locale? locale,
    Iterable<Locale> supportedLocales,
  ) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale?.languageCode &&
          supportedLocale.countryCode == locale?.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }
}
