import 'package:shared_preferences/shared_preferences.dart';

class LoginSession {
  static const String _loginKey = "login";

  static Future<void> setLoginSession(bool isLoggedIn) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(_loginKey, isLoggedIn);
  }

  static Future<bool> getLoginSession() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(_loginKey) ?? false;
  }

  static Future<void> clearSession() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_loginKey);
  }
}
