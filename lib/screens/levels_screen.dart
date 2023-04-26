import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiddy_maths/controllers.dart/current_level.dart';
import 'package:kiddy_maths/controllers.dart/levels.dart';
import 'package:kiddy_maths/controllers.dart/operator_cont.dart';
import 'package:kiddy_maths/controllers.dart/question_provider.dart';
import 'package:kiddy_maths/controllers.dart/questions_reg_cont.dart';
import 'package:kiddy_maths/controllers.dart/score_cont.dart';
import 'package:kiddy_maths/controllers.dart/timer_controller.dart';
import 'package:kiddy_maths/screens/question_screen.dart';
import 'package:kiddy_maths/utils/navigator.dart';

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/forest1.svg",
            color: Theme.of(context).cardColor,
            colorBlendMode: BlendMode.colorDodge,
            fit: BoxFit.cover,
          ),
          const Levels(),
        ],
      ),
    );
  }
}

class Levels extends ConsumerWidget {
  const Levels({
    Key? key,
  }) : super(key: key);

  retrieveStage(WidgetRef ref) {
    final operator = ref.watch(operatorCont);
    ref.watch(levelsCont.notifier).retrieve(operator!.operation);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    retrieveStage(ref);
    var openedStages = ref.watch(levelsCont);

    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, currentStage) {
          return GestureDetector(
            onTap: () {
              if (openedStages >= currentStage) {
                final operator = ref.watch(operatorCont);
                final questions = ref
                    .watch(questionsCont.notifier)
                    .getQuestions(operator!.operation, currentStage + 1);

                ref.watch(questionRegCont.notifier).reset();
                ref.watch(scoreCont.notifier).reset();
                ref.watch(timerCont.notifier).reset();
                ref.read(currentLevelCont.notifier).set(currentStage + 1);

                MyNavigator.goto(
                    context,
                    Questionscreen(
                      questions: questions!,
                      level: currentStage + 1,
                    ));
              }
            },
            child: _LevelTile(
              openedStages: openedStages,
              currentStage: currentStage,
            ),
          );
        });
  }
}

class _LevelTile extends StatelessWidget {
  const _LevelTile(
      {Key? key, required this.openedStages, required this.currentStage})
      : super(key: key);

  final int openedStages;
  final int currentStage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          "assets/Fall_Panel.svg",
          width: 100,
          height: 90,
        ),
        openedStages >= currentStage
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${currentStage + 1} ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "level",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              )
            : const Center(
                child: Icon(Icons.lock),
              )
      ],
    );
  }
}
