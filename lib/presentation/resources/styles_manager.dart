import 'package:agence_voyage/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(
  String? fontFamily,
  double fontSize,
  FontWeight fontWeight,
  Color? color,
) {
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

//light
TextStyle getLightStyle(
    {String? fontFamily, double fontSize = FontSize.s20, Color? color}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.light, color);
}

//regular
TextStyle getRegularStyle(
    {String? fontFamily, double fontSize = FontSize.s20, Color? color}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.regular, color);
}

//medium
TextStyle getMediumStyle(
    {String? fontFamily, double fontSize = FontSize.s20, Color? color}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.medium, color);
}

//semiBold
TextStyle getSemiBoldStyle(
    {String? fontFamily, double fontSize = FontSize.s20, Color? color}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.semiBold, color);
}

//bold
TextStyle getBoldStyle(
    {String? fontFamily, double fontSize = FontSize.s20, Color? color}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.bold, color);
}
