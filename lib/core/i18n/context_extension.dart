import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

extension LocalizationExtension on BuildContext {
  String t(String key) => AppLocalizations.of(this)!.t(key);
  String tt(String en, String ar) => AppLocalizations.of(this)!.tt(en, ar);
}
