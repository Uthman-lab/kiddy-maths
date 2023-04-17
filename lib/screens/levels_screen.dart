import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiddy_maths/business_logic/quiz_generator.dart';
import 'package:kiddy_maths/controllers/stageController.dart';
import 'package:kiddy_maths/screens/question_screen.dart';
import 'package:kiddy_maths/utils/local_storage.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var stages = ref.watch(openStages);
    
    return stages.when(
        error: (error, stackTrace) => Center(
              child: Text("$error"),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        data: (openStage) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    int currentStage = ref.read(level.notifier).get(1 + index);
                    Operation operator = ref.read(operation);
                    List<Question> questions = ref
                        .read(questionsController.notifier)
                        .getQuestions(currentStage, operator, openStage);

                    if (questions.isNotEmpty) {
                      MyNavigator.goto(
                          context, Questionscreen(questions: questions));
                    }
                    ref.read(questionsController.notifier).reset();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/Fall_Panel.svg",
                        width: 100,
                        height: 90,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ref
                                    .watch(questionsController.notifier)
                                    .checkStatus(openStage, index)
                                ? Text(
                                    "${index + 1} ",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )
                                : const Icon(Icons.lock),
                            Text(
                              "level",
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        });
  }
}
