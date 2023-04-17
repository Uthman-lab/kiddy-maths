import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static void store(String key, int level) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, level);
  }

  static Future<int> retrieve(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 1;
  }
}
