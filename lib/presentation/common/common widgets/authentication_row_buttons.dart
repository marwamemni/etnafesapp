import 'package:agence_voyage/presentation/resources/assets_manager.dart';
import 'package:agence_voyage/presentation/resources/routes_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Padding getDownRowButtons(
    Stream<bool>? stream, Function()? onTap, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.splashRoute);
          },
          child: SvgPicture.asset(
            ImageAssets.backIcon,
            fit: BoxFit.cover,
            height: AppSize.s50,
            width: AppSize.s50,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: AppMargin.m6),
          child: StreamBuilder<bool>(
              stream: stream,
              builder: (context, snapshot) {
                return GestureDetector(
                  onTap: snapshot.data ?? false ? onTap : null,
                  child: SvgPicture.asset(
                    ImageAssets.checkIcon,
                    fit: BoxFit.cover,
                    height: AppSize.s50,
                    width: AppSize.s50,
                  ),
                );
              }),
        ),
      ],
    ),
  );
}
