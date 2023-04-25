import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiddy_maths/controllers.dart/levels.dart';
import 'package:kiddy_maths/controllers.dart/operator_cont.dart';
import 'package:kiddy_maths/controllers.dart/question_provider.dart';
import 'package:kiddy_maths/screens/home_screen.dart';
import 'package:kiddy_maths/screens/levels_screen.dart';
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
              Text("level ${ref.watch(levelsCont) + 1}"),
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
                        MyNavigator.removeAndGoto(context, const LevelsScreen());
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
                        MyNavigator.removeAndGoto(context, const LevelsScreen());
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
}
