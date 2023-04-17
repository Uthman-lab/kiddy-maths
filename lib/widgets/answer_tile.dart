import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiddy_maths/screens/scores_screen.dart';
import 'package:kiddy_maths/utils/local_storage.dart';
import 'package:kiddy_maths/utils/navigator.dart';


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
