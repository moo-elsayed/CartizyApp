import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static const String isFirstTimeKey = 'isFirstTime';
  static const String isUserLoggedInKey = 'isUserLoggedIn';
  static const String userTokenKey = 'userToken';
  static const String refreshTokenKey = 'refreshToken';
  static const String lastFetchTimeKey = 'lastFetchTime';

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

  static Future<void> setUserToken(String userToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userTokenKey, userToken);
  }

  static Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userTokenKey) ?? '';
  }

  static Future<void> setRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(refreshTokenKey, refreshToken);
  }

  static Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshTokenKey) ?? '';
  }

  static Future<void> setLastFetchTime(DateTime time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(lastFetchTimeKey, time.millisecondsSinceEpoch);
  }

  static Future<DateTime?> getLastFetchTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final millis = prefs.getInt(lastFetchTimeKey);
    if (millis == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }
}
