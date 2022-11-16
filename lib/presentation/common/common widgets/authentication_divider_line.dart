import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

Widget divider() {
  return Container(
    height: 0.3,
    width: double.infinity,
    decoration: BoxDecoration(color: ColorManager.grey, boxShadow: [
      BoxShadow(
          color: ColorManager.black.withOpacity(AppOpacity.o07),
          spreadRadius: 0.2,
          blurRadius: 5,
          offset: const Offset(0, 1.5))
    ]),
  );
}
