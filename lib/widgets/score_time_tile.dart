import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiddy_maths/controllers.dart/score_cont.dart';
import 'package:kiddy_maths/screens/home_screen.dart';
import 'package:kiddy_maths/screens/scores_screen.dart';
import 'package:kiddy_maths/utils/navigator.dart';

import '../controllers.dart/timer_controller.dart';

class ScoreAndTimePanel extends ConsumerWidget {
  const ScoreAndTimePanel({
    super.key,
  });
  //final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const DisplayTime(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        CustomRoundedButton(
          height: 50,
          child: Center(
              child: Text(
            "${ref.watch(scoreCont)}",
            style: GoogleFonts.rubikDirt(fontSize: 24),
          )),
        ),
      ],
    );
  }
}

class DisplayTime extends ConsumerWidget {
  const DisplayTime({super.key});

  changeColor(Duration duration) {
    Color color = Colors.black;
    if (duration <= const Duration(seconds: 60)) {
      color = Colors.yellow;
    }
    if (duration <= const Duration(seconds: 15)) {
      color = Colors.red;
    }
    return color;
  }

  checkAndEndGame(WidgetRef ref, BuildContext context) {
    final duration = ref.watch(timerCont).duration;
    if (duration.inSeconds == 0) {
      ref.watch(timerCont.notifier).reset();
      Future.microtask(
          () => MyNavigator.removeAndGoto(context, const ScoresScreen()));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(timerCont).duration;
    final timerColor = changeColor(duration);
    checkAndEndGame(ref, context);
    return CustomRoundedButton(
      height: 60,
      child: Center(
          child: Text(
        "${duration.inMinutes}:${duration.inSeconds % 60}",
        textAlign: TextAlign.center,
        style: GoogleFonts.rubikDirt(fontSize: 24, color: timerColor),
      )),
    );
  }
}
