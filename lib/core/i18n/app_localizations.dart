import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_localizations_delegate.dart';

class AppLocalizations {
  late final Locale locale;

  AppLocalizations(this.locale);
  static List<Locale> get supportedLanguages =>
      const AppLocalizationsDelegate().supportedLanguages;
  bool isSupported(Locale type) =>
      const AppLocalizationsDelegate().isSupported(type);

  // Helper method to keep the code in the widgets concise Localizations are
  // accessed using an InheritedWidget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  Map<String, String> _localizedStrings = {};
  Map<String, String> _localizedStringsDefault = {};

  Map<String, String> flattenTranslations(Map<String, dynamic> json,
      [String prefix = '']) {
    final Map<String, String> translations = {};
    json.forEach((String key, dynamic value) {
      if (value is Map<String, dynamic>) {
        translations.addAll(flattenTranslations(value, '$prefix$key.'));
      } else {
        translations['$prefix$key'] = value.toString();
      }
    });
    return translations;
  }

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString =
        await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = flattenTranslations(jsonMap);

    String jsonStringEn = await rootBundle.loadString('assets/i18n/en.json');
    Map<String, dynamic> jsonMapEn = json.decode(jsonStringEn);
    _localizedStringsDefault = jsonMapEn.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String tt(String en, String ar) => locale.languageCode == 'ar' ? ar : en;

  // This method will be called from every widget which needs a localized text
  String t(String key) => _localizedStrings[key] != null
      ? _localizedStrings[key].toString()
      : _localizedStringsDefault[key] != null
          ? _localizedStringsDefault[key].toString()
          : key;
}
