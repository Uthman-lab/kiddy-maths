import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/bg.gif",
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        child
      ],
    );
  }
}
