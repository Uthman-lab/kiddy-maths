import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiddy_maths/screens/home_screen.dart';
import 'package:kiddy_maths/screens/levels_screen.dart';
import 'package:kiddy_maths/utils/navigator.dart';

import '../controllers/stageController.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text("level ${ref.watch(level)}"),
              const SizedBox(
                height: 20,
              ),
              const Text("Your score "),
              const SizedBox(
                height: 20,
              ),
              Text("${ref.watch(scoreController)}"),
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
                        MyNavigator.removeUntil(
                            context, MyNavigator.homeScreen);
                      },
                      child: const Icon(Icons.home)),
                  const SizedBox(
                    width: 50,
                  ),
                  CustomRoundedButton(
                      height: 50,
                      width: 70,
                      ontap: () {
                        MyNavigator.removeAndGoto(context, LevelsScreen());
                      },
                      child: const Icon(Icons.redo)),
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
