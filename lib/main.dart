import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddy_maths/screens/home_screen.dart';
import 'package:kiddy_maths/screens/levels_screen.dart';
import 'package:kiddy_maths/screens/question_screen.dart';
import 'package:kiddy_maths/screens/scores_screen.dart';
import 'package:kiddy_maths/themes.dart';
import 'package:kiddy_maths/utils/navigator.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomThemes.themes(),
      routes: MyNavigator.routes(context),
      initialRoute: MyNavigator.homeScreen,
    );
  }
}
