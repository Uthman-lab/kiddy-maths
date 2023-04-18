import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final questionRegCont = StateNotifierProvider<QuestionsRegulatorCont, int>(
    (ref) => QuestionsRegulatorCont());

class QuestionsRegulatorCont extends StateNotifier<int> {
  QuestionsRegulatorCont() : super(0);

  void increment() => state >= 9 ? state = 9 : state++;

  void decrement() => state--;

  void moveTo(int n) => state = n;
}
