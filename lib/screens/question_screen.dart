import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:kiddy_maths/controllers.dart/levels.dart';
import 'package:kiddy_maths/controllers.dart/operator_cont.dart';
import 'package:kiddy_maths/controllers.dart/questions_reg_cont.dart';
import 'package:kiddy_maths/screens/home_screen.dart';
import 'package:kiddy_maths/screens/scores_screen.dart';
import 'package:kiddy_maths/utils/navigator.dart';

import '../business_logic/quiz_generator.dart';
import '../widgets/answer_tile.dart';
import '../widgets/banner.dart';
import '../widgets/question_tile.dart';

class Questionscreen extends ConsumerWidget {
  const Questionscreen({super.key, required this.questions});
  final List<Question> questions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(questionRegCont);
    final quest = questions[index];
    final operator = ref.watch(operatorCont);
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/bg2.svg",
            color: Theme.of(context).shadowColor,
            colorBlendMode: BlendMode.colorBurn,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                        height: 100,
                        child: CustomBanner(
                          level: ref.watch(levelsCont) + 1,
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    QuestionTile(
                        // screenSize: size,
                        first: quest.first,
                        second: quest.second,
                        sign: operator!.sign),
                    const SizedBox(
                      height: 30,
                    ),
                    AnswerTile(
                      answer: quest.answer,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomRoundedButton(
                        height: 50,
                        ontap: () {
                          MyNavigator.removeAndGoto(
                              context, const ScoresScreen());
                        },
                        child: Center(
                            child: Text("Exit",
                                style: GoogleFonts.rubikDirt(fontSize: 42)))),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
