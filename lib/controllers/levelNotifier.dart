import 'package:flutter_riverpod/flutter_riverpod.dart';

class LevelNotifier extends StateNotifier<int> {
  LevelNotifier() : super(1);

  get(int level) {
    state = level;
    return state;
  }
}
