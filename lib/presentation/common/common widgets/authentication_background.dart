import 'package:agence_voyage/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget getBackgroundWidget(Size size, Widget? child) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width / 4, vertical: size.height / 12),
        child: SizedBox(
          height: size.width / 5.2,
          width: size.width / 2,
          child: SvgPicture.asset(
            ImageAssets.logo,
            fit: BoxFit.contain,
          ),
        ),
      ),
      if (child != null) child,
      SizedBox(
        height: size.width / 1.5,
        width: size.width,
        child: SvgPicture.asset(
          ImageAssets.splashScreenBackground,
          fit: BoxFit.fitWidth,
        ),
      ),
    ],
  );
}
