import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    Key? key,
    required this.level,
  }) : super(key: key);
  final int level;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SvgPicture.asset(
        "assets/Banner33.svg",
        fit: BoxFit.cover,
      ),
      Center(
        child: Text(
          "level $level ",
          style: GoogleFonts.rubikDirt(fontSize: 24),
        ),
      ),
    ]);
  }
}
