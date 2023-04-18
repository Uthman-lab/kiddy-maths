import 'package:kiddy_maths/business_logic/quiz_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveToPrefs {
 static Future<void> save(Operation operator, int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(operator.name, level);
  }

static  Future retrieve(Operation operator) async {
    final prefs = await SharedPreferences.getInstance();
  return  prefs.getInt(operator.name) ?? 0;
  }
}
