import 'package:flutter_riverpod/flutter_riverpod.dart';

var scoreCont =
    StateNotifierProvider<ScoreController, int>((ref) => ScoreController());

class ScoreController extends StateNotifier<int> {
  ScoreController() : super(0);
  reset() => state = 0;
  increment() => state++;
  decrement() => state--;

  bool checkPass(int totalScore) {
   return state / totalScore * 100 >= 80;
  }
}
