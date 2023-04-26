import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentLevelCont =
    StateNotifierProvider<CurrentLevelState, int>((ref) => CurrentLevelState());

class CurrentLevelState extends StateNotifier<int> {
  CurrentLevelState() : super(0);

  increament() {
    state++;
  }

  set(int newLevel) {
    Future.delayed(const Duration(seconds: 1), () => state = newLevel);
  }
}
