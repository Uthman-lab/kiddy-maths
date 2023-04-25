import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiddy_maths/screens/scores_screen.dart';
import 'package:kiddy_maths/utils/navigator.dart';

import '../controllers.dart/question_provider.dart';
import '../controllers.dart/questions_reg_cont.dart';
import '../controllers.dart/score_cont.dart';

class AnswerTile extends ConsumerWidget {
  const AnswerTile({
    required this.answer,
    Key? key,
  }) : super(key: key);
  final int answer;

  List<int> possibleAnswers() {
    Random randomObj = Random();
    int rand = randomObj.nextInt(5) + 1;
    List<int> result = [];
    result
      ..add((answer))
      ..add(answer - rand)
      ..add(answer + rand)
      ..add(answer + 2 * rand);
    result = result.map((e) => e.abs()).toList();
    return result;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List res = possibleAnswers();
    res.shuffle();
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          "assets/Anonymous-Panel.svg",
          color: Colors.brown.shade800,
          colorBlendMode: BlendMode.colorBurn,
        ),
        GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 50),
            padding: EdgeInsets.zero,
            itemCount: res.length,
            itemBuilder: (context, index) {
              //   res.shuffle();
              return GestureDetector(
                onTap: () {
                  bool isCorrect = ref
                      .watch(questionsCont.notifier)
                      .verifyAnswer(answer, res[index]);
                  if (isCorrect) {
                    ref.watch(scoreCont.notifier).increment();
                    ref.watch(questionRegCont.notifier).increment();
                  } else {
                    ref.watch(questionRegCont.notifier).increment();
                  }
                  final lastIndex =
                      ref.watch(questionsCont.select((value) => value.length)) -
                          1;
                  print(lastIndex);

                  final qIndex = ref.watch(questionRegCont);
                  bool isLast = lastIndex == qIndex;
                  print("islast $lastIndex index $qIndex");

                  if (isLast) {
                    MyNavigator.goto(context, const ScoresScreen());
                  }
                },
                child: Center(
                  child: Text(
                    "${res[index]}  ",
                    style: GoogleFonts.rubikDistressed(fontSize: 42),
                  ),
                ),
              );
            })
      ],
    );
  }
}
