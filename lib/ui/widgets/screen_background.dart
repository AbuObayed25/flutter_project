import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utility/asstes_path.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {

    Size screenSize =MediaQuery.sizeOf(context);  // short kortasi amar bujar jonno

    return Stack(
      children: [
        SvgPicture.asset(
          AsstesPath.backgroundSvg,
          fit: BoxFit.cover,
          height: screenSize.height,
          width:screenSize.width,
        ),
        SafeArea(child: child),
      ],
    );
  }
}