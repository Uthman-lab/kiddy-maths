import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddy_maths/business_logic/quiz_generator.dart';
import 'package:kiddy_maths/controllers/stageController.dart';
import 'package:kiddy_maths/screens/levels_screen.dart';
import 'package:kiddy_maths/utils/navigator.dart';
import 'package:kiddy_maths/widgets/background.dart';

class SelectOperatorScreen extends ConsumerWidget {
  const SelectOperatorScreen({super.key});

  List<Map<String, Object>> operators() {
    var a = {"operator": Operation.add, "icon": "+"};
    var b = {"operator": Operation.sub, "icon": "-"};
    var c = {"operator": Operation.multiply, "icon": "*"};
    return [a, b, c];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Background(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleWidge(),
            ...operators().map((e) {
              return Container(
                  margin: const EdgeInsets.all(20),
                  child: OperatorButton(operator: e));
            }),
          ],
        ),
      ),
    ));
  }
}

class TitleWidge extends StatelessWidget {
  const TitleWidge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "MATHS QUIZ FOR KIDS",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class CustomCircularButton extends StatelessWidget {
  const CustomCircularButton({Key? key, required this.child, this.onTap})
      : super(key: key);
  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Colors.blueAccent),
        child: child,
      ),
    );
  }
}

class OperatorButton extends ConsumerWidget {
  const OperatorButton({Key? key, required this.operator, this.onTap})
      : super(key: key);
  final Map<String, Object> operator;
  final Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    selectOperatorAndNavigate() {
      Operation newOperator = operator["operator"] as Operation;
      ref.read(operation.notifier).selectOperator(newOperator);
      MyNavigator.goto(context, const LevelsScreen());
    }

    return GestureDetector(
      onTap: selectOperatorAndNavigate,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).cardColor),
        child: Center(child: Text("${operator["icon"]}")),
      ),
    );
  }
}
