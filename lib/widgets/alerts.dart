import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers.dart/timer_controller.dart';
import '../screens/home_screen.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({
    required this.ref,
    Key? key,
  }) : super(key: key);
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: AlertDialog(
          content: CustomRoundedButton(
            height: 50,
            width: 80,
            child: Center(child: Text("Resume")),
            ontap: () {
              ref.watch(timerCont.notifier).resume();
              Navigator.pop(context);
            },
          ),
        ),
        onWillPop: () async {
          bool isPause = ref.watch(timerCont).isPaused;
          if (isPause == true) {
            print("pop");
            return false;
          } else {
            return true;
          }
        });
  }
}
