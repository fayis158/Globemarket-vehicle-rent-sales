import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPreferences {
  static Future<bool> saveInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.setInt(key, value);
  }

  // static Future<bool> setLoggedIn(String key, bool value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.setBool(key, value);
  // }

  // static Future<bool?> isLoggedIn(String key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.containsKey("uid");
  //   return prefs.getBool(key);
  // }

  static Future<int?> getInt(String key1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key1);
  }

  static Future<bool> remove(String key2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key2);
  }


  //for name of user

  // static Future<bool> saveStringName(String key, String value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
    
  //   return prefs.setString(key, value);
  // }
  //  static Future<String?> getStringName(String key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(key);
  // }

}
