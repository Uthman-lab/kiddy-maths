import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerCont =
    StateNotifierProvider<TimerState, MTimer>((ref) => TimerState());

class TimerState extends StateNotifier<MTimer> {
  static Duration instanceDuration = const Duration(seconds: _limit);
  static const int _limit = 120;
  TimerState()
      : super(MTimer(
          const Duration(seconds: _limit),
          true,
        ));

  StreamSubscription? _subscription;

  play() {
    _subscription = _streamValues(60).listen((s) {
      _limit <= s
          ? instanceDuration = const Duration(seconds: 0)
          : instanceDuration = Duration(seconds: _limit - s);
      state = MTimer(instanceDuration, false);
    });
  }

  Stream<int> _streamValues(int seconds) {
    return Stream.periodic(const Duration(seconds: 1), (t) => t);
  }

  reset() {
    if (_subscription != null) _subscription!.cancel();
    play();
  }

  pausePlay() {
    if (state.isPaused) {
      _resume();
    } else {
      _pause();
    }
  }

  _pause() {
    state = MTimer(instanceDuration, true);
    _subscription?.pause();
  }

  _resume() {
    _subscription?.resume();
  }
}

class MTimer {
  final Duration duration;
  bool isPaused;

  MTimer(
    this.duration,
    this.isPaused,
  );

  @override
  bool operator ==(Object other) =>
      other is MTimer &&
      isPaused == other.isPaused &&
      duration == other.duration;

  @override
  int get hashCode => Object.hash(isPaused.hashCode, duration.hashCode);
}
