import 'package:agence_voyage/presentation/resources/assets_manager.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget getCustomAddCardWidget(void Function() fun,
    {EdgeInsetsGeometry? margin}) {
  return GestureDetector(
    onTap: () {
      fun();
    },
    child: Container(
      height: AppSize.s200 + AppSize.s45,
      margin: margin,
      decoration: BoxDecoration(
          color: ColorManager.orangeclair,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(AppSize.s25),
              bottomRight: Radius.circular(AppSize.s25))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: AppSize.s200,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Container(
                color: ColorManager.white,
                child: Center(
                  child: SvgPicture.asset(
                    ImageAssets.addIcon,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: AppSize.s45,
          )
        ],
      ),
    ),
  );
}
