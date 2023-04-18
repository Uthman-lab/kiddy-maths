import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddy_maths/business_logic/quiz_generator.dart';
import 'package:kiddy_maths/business_logic/save_to_prefs.dart';

final levelsCont =
    StateNotifierProvider<LevelsCont, int>((ref) => LevelsCont());

class LevelsCont extends StateNotifier<int> {
  LevelsCont() : super(0);

  void saveToPrefs(Operation operator, int level) async {
    try {
      await SaveToPrefs.save(operator, level);
    } catch (e) {
      print("error is $e");
    }
  }

  void retrieve(Operation operator) async {
    try {
      state = await SaveToPrefs.retrieve(operator);
    } catch (e) {
      print("error $e");
    }
  }
}
