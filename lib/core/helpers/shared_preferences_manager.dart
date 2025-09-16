import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static const String isFirstTimeKey = 'isFirstTime';
  static const String isUserLoggedInKey = 'isUserLoggedIn';

  static Future<void> setFirstTime(bool isFirstTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isFirstTimeKey, isFirstTime);
  }

  static Future<bool> getFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isFirstTimeKey) ?? true;
  }

  static Future<void> setUserLoggedIn(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isUserLoggedInKey) ?? false;
  }
}
