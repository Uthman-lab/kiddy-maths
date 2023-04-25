import 'package:flutter/material.dart';
import 'package:kiddy_maths/screens/home_screen.dart';
import 'package:kiddy_maths/screens/levels_screen.dart';
import 'package:kiddy_maths/screens/select_operator_screen.dart';

class MyNavigator {
  static String homeScreen = "/";
  static String operatorScreen = "/operatorscreen";
  static String levelScreen = "/levelScreen";
  static Map<String, Widget Function(BuildContext)> routes(
      BuildContext context) {
    return {
      homeScreen: (context) => const HomeScreen(),
      operatorScreen: (context) => const SelectOperatorScreen(),
      levelScreen: (context) => const LevelsScreen()
    };
  }

  static goto(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static removeAndGoto(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static removeUntil(BuildContext context, String screen) {
    Navigator.of(context).popUntil(ModalRoute.withName(screen));
  }
}
