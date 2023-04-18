import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiddy_maths/controllers.dart/score_cont.dart';
import 'package:kiddy_maths/screens/home_screen.dart';

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

class DisplayTime extends StatefulWidget {
  const DisplayTime({
    Key? key,
  }) : super(key: key);

  @override
  State<DisplayTime> createState() => _DisplayTimeState();
}

class _DisplayTimeState extends State<DisplayTime> {
  late Stream<Duration> timer;

  @override
  void initState() {
    timer = Stream<Duration>.periodic(const Duration(seconds: 1), (t) {
      return Duration(seconds: 0 + t);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRoundedButton(
      height: 60,
      child: Center(
          child: StreamBuilder<Duration>(
              stream: timer,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.requireData;

                  return Text(
                    "${data.inHours % 24} : ${data.inMinutes % 60} : ${data.inSeconds % 60}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubikDirt(fontSize: 24),
                  );
                }
                return const Text("00 : 00");
              })),
    );
  }
}
