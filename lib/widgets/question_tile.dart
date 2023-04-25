import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiddy_maths/widgets/score_time_tile.dart';

class QuestionTile extends StatelessWidget {
  const QuestionTile(
      {Key? key,
      //  required this.screenSize,
      required this.first,
      required this.sign,
      required this.second})
      : super(key: key);
  final int first;
  final int second;
  final String sign;
  // final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      SvgPicture.asset(
        "assets/Anonymous-Panel.svg",
      ),
      const Positioned.fill(
          bottom: 60,
          child:
              Align(alignment: Alignment(0, -1.2), child: ScoreAndTimePanel())),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$first   $sign   $second ",
          ),
          const Text(
            "= ?",
          )
        ],
      ),
    ]);
  }
}
