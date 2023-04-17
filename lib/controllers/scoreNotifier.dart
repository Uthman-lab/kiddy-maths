import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreNotifier extends StateNotifier<int> {
  ScoreNotifier() : super(0);

  score(answer, selected) {
    if (selected == answer) state++;
  }
}
