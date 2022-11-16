import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

Widget loadingWidget() {
  return Center(
      child: CircularProgressIndicator(
    color: ColorManager.orange,
  ));
}
