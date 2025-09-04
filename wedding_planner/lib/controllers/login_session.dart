import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LoginSession {
  static bool isLoggin = false;
  static String userEmail = "";
  static Future<void> setLoginSession(bool isLogin, String userMail) async {
    SharedPreferences spObj = await SharedPreferences.getInstance();

    await spObj.setBool("login", isLogin);
    await spObj.setString("user", userMail);

    await getLoginSession();
  }

  static Future<void> getLoginSession() async {
    SharedPreferences spObj = await SharedPreferences.getInstance();
    isLoggin = spObj.getBool("login") ?? false;
    log("${spObj.getString("user")}");
    userEmail = spObj.getString("user") ?? "";
  }
}
