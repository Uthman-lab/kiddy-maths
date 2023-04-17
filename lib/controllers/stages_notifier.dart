import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddy_maths/business_logic/quiz_generator.dart';
import 'package:kiddy_maths/utils/local_storage.dart';

class OpenStageNotifier extends StateNotifier<int> {
  OpenStageNotifier() : super(0);

  unlock() {
    state++;
  }

  checkStatus(int index) {
    if (state > index) return true;
    return false;
  }

  getStageFromStorage(Operation operator) async {
    print("open $state");
  }

  openNextStage(int level, int openstaged, int score, Operation key) async {
    print("level $level and opened $openstaged");
    if (level == openstaged && score > 8) {
      LocalStorage.store(key.name, ++openstaged);
      print("stage is ${await LocalStorage.retrieve(key.name)}");
    }
  }
}
