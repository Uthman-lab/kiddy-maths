import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiddy_maths/controllers.dart/current_level.dart';
import 'package:kiddy_maths/controllers.dart/levels.dart';
import 'package:kiddy_maths/controllers.dart/operator_cont.dart';
import 'package:kiddy_maths/controllers.dart/question_provider.dart';
import 'package:kiddy_maths/controllers.dart/timer_controller.dart';
import 'package:kiddy_maths/screens/home_screen.dart';
import 'package:kiddy_maths/screens/levels_screen.dart';
import 'package:kiddy_maths/screens/question_screen.dart';
import 'package:kiddy_maths/screens/select_operator_screen.dart';
import 'package:kiddy_maths/utils/navigator.dart';

import '../controllers.dart/score_cont.dart';

class ScoresScreen extends ConsumerWidget {
  const ScoresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(children: [
        SvgPicture.asset(
          "assets/bg2.svg",
          color: Colors.amber,
          colorBlendMode: BlendMode.colorBurn,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        const ScoreBoard(),
      ]),
    );
  }
}

class ScoreBoard extends ConsumerWidget {
  const ScoreBoard({
    Key? key,
  }) : super(key: key);

  checkAndIncreaseLevel(WidgetRef ref) {
    final total = ref.watch(questionsCont.select((value) => value.length));
    bool isPass = ref.watch(scoreCont.notifier).checkPass(total);
    if (isPass) {
      int level = ref.read(levelsCont) + 1;
      final operator = ref.read(operatorCont);
      ref.read(levelsCont.notifier).saveToPrefs(operator!.operation, level);
    }
    ref.watch(scoreCont.notifier).reset();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask(() => ref.watch(timerCont.notifier).stop());
    return Stack(
      children: [
        SvgPicture.asset(
          "assets/scores.svg",
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("level ${ref.watch(currentLevelCont)}"),
              const SizedBox(
                height: 20,
              ),
              const Text("Your score "),
              const SizedBox(
                height: 20,
              ),
              Text("${ref.watch(scoreCont)}"),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomRoundedButton(
                      height: 50,
                      width: 70,
                      ontap: () {
                        checkAndIncreaseLevel(ref);
                        MyNavigator.removeUntil(
                            context, MyNavigator.homeScreen);
                      },
                      child: const Icon(Icons.home)),
                  const SizedBox(
                    width: 30,
                  ),
                  CustomRoundedButton(
                      height: 50,
                      width: 70,
                      ontap: () {
                        checkAndIncreaseLevel(ref);
                        final operator = ref.watch(operatorCont);
                        final currentLevel = ref.watch(currentLevelCont);
                        final questions = ref
                            .watch(questionsCont.notifier)
                            .getQuestions(operator!.operation, currentLevel);
                        MyNavigator.removeAndGoto(
                            context,
                            Questionscreen(
                              level: currentLevel,
                              questions: questions!,
                            ));
                        ref.watch(timerCont.notifier).reset();
                      },
                      child: const Icon(Icons.redo_rounded)),
                  const SizedBox(
                    width: 30,
                  ),
                  CustomRoundedButton(
                      height: 50,
                      width: 70,
                      ontap: () {
                        checkAndIncreaseLevel(ref);

                        final operator = ref.watch(operatorCont);

                        ref
                            .watch(levelsCont.notifier)
                            .retrieve(operator!.operation)
                            .then((openedLevels) {
                          final currentLevel = ref.watch(currentLevelCont);
                          final nextLevel = currentLevel + 1;
                          print("runed");

                          gotoNextQuestionsPage(
                              nextLevel: nextLevel,
                              openedLevels: openedLevels,
                              ref: ref,
                              context: context,
                              operator: operator);
                        });
                      },
                      child: const Icon(Icons.arrow_forward)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  gotoNextQuestionsPage(
      {required int nextLevel,
      required int openedLevels,
      required WidgetRef ref,
      required BuildContext context,
      required Operator operator}) {
    if (nextLevel <= openedLevels + 1) {
      final questions = ref
          .watch(questionsCont.notifier)
          .getQuestions(operator.operation, nextLevel);
      ref.read(currentLevelCont.notifier).set(nextLevel);
      MyNavigator.removeAndGoto(
          context,
          Questionscreen(
            level: nextLevel,
            questions: questions!,
          ));
      ref.watch(timerCont.notifier).reset();
    } else {
      const info =
          "You are not eligible for this level, try passing the current stage";
      _showDialog(context, info);
      //TO DO show snack

    }
  }

  _showDialog(BuildContext context, String info) {
    showBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            child: Text(
              info,
              softWrap: true,
            ),
          );
        });
  }
}
