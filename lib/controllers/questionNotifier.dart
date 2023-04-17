import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionCountNotifier extends StateNotifier<int> {
  QuestionCountNotifier() : super(0);

  bool getIsLast() {
    return state >= 9 ? true : false;
  }

  increment() {
    state++;
  }

  initialize() {
    state = 0;
  }
}
