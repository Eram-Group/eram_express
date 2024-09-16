import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static setbool(String key, bool value) {
    _prefs.setBool(key, value) ?? false;
  }

  static bool getbool(String key) {
    return _prefs.getBool(key) ?? false;
  }
}
