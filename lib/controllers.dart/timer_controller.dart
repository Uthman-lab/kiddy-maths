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
    state = MTimer(
      const Duration(seconds: _limit),
      true,
    );
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

  stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  bool? isPause() {
    return _subscription?.isPaused;
  }

  reset() {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }

    play();
  }

  pause() {
    state = MTimer(instanceDuration, true);
    _subscription?.pause();
  }

  resume() {
    _subscription?.resume();
    state = MTimer(instanceDuration, false);
  }
}

class MTimer {
  final Duration duration;
  bool isPaused;

  MTimer(
    this.duration,
    this.isPaused,
  );
}
