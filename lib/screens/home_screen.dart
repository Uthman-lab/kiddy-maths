import 'package:flutter/material.dart';
import 'package:kiddy_maths/screens/select_operator_screen.dart';
import 'package:kiddy_maths/utils/navigator.dart';
import 'package:kiddy_maths/widgets/background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            const TitleWidge(),
            const Spacer(),
            CustomRoundedButton(
              width: 140,
              ontap: () =>
                  MyNavigator.goto(context, const SelectOperatorScreen()),
              child: const Center(
                child: Text(
                  "PLAY",
                ),
              ),
            ),
            const SizedBox(height: 10),
            const CustomRoundedButton(
              width: 210,
              child: Center(
                child: Text(
                  "OPTIONS",
                ),
              ),
            ),
            const SizedBox(height: 10),
            const CustomRoundedButton(
              child: Center(
                child: Text(
                  "EXIT",
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const CustomRoundedButton(
                child: Icon(
              Icons.share,
              size: 50,
            )),
            const Spacer()
          ],
        ),
      )),
    );
  }
}

class TitleWidge extends StatelessWidget {
  const TitleWidge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("MATHS QUIZ FOR KIDS",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge);
  }
}

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton(
      {Key? key, required this.child, this.height, this.width, this.ontap})
      : super(key: key);
  final Widget child;
  final double? height;
  final double? width;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: width ?? 120,
        height: height ?? 100, //  padding: const EdgeInsets.,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).shadowColor, width: 3),
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).cardColor),
        child: child,
      ),
    );
  }
}
