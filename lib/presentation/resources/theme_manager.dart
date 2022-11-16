// ignore_for_file: deprecated_member_use

import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/font_manager.dart';
import 'package:agence_voyage/presentation/resources/styles_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors
      primaryColor: ColorManager.bleuclair,
      primaryColorLight: ColorManager.bleuclair,
      primaryColorDark: ColorManager.orangeclair,
      disabledColor: ColorManager.grey,
      splashColor: ColorManager.bleuclair,
      canvasColor: ColorManager.white,
      // ripple effect color
      // cardview theme
      cardTheme: CardTheme(
          color: ColorManager.orange,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),
      // app bar theme
      appBarTheme: AppBarTheme(
          color: ColorManager.orangeclair,
          elevation: AppSize.s4,
          shadowColor: ColorManager.black,
          titleTextStyle: getRegularStyle(
              fontSize: FontSize.s16, color: ColorManager.white)),
      // button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey,
          buttonColor: ColorManager.orange,
          splashColor: ColorManager.bleuclair),

      // elevated button them
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              onPrimary: ColorManager.black,
              textStyle: getRegularStyle(
                  fontFamily: FontConstants.swiss721Family,
                  color: ColorManager.black,
                  fontSize: FontSize.s25),
              shadowColor: ColorManager.black,
              minimumSize: const Size(AppSize.s200, AppSize.s50),
              elevation: AppSize.s12,
              primary: ColorManager.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s25)))),
      textTheme: TextTheme(
        displayLarge: getBoldStyle(
            color: ColorManager.black,
            fontSize: FontSize.s30,
            fontFamily: FontConstants.stikaHeadingFamily),
        headlineLarge: getBoldStyle(
            color: ColorManager.white,
            fontSize: FontSize.s25,
            fontFamily: FontConstants.stikaHeadingFamily),
        headlineMedium: getRegularStyle(
            fontFamily: FontConstants.swiss721Family,
            color: ColorManager.black,
            fontSize: FontSize.s30),
        titleMedium: getRegularStyle(
            color: ColorManager.grey,
            fontSize: FontSize.s17,
            fontFamily: FontConstants.swiss721Family),
        titleSmall: getRegularStyle(
            color: ColorManager.grey,
            fontSize: FontSize.s15,
            fontFamily: FontConstants.swiss721Family),
        // bodyLarge: getRegularStyle(color: ColorManager.grey1),
        bodySmall: getRegularStyle(
            color: ColorManager.grey,
            fontSize: FontSize.s20,
            fontFamily: FontConstants.swiss721Family),
        bodyMedium: getRegularStyle(
            color: ColorManager.grey,
            fontSize: FontSize.s25,
            fontFamily: FontConstants.swiss721Family),
        labelSmall: getRegularStyle(
            color: ColorManager.grey,
            fontSize: FontSize.s12,
            fontFamily: FontConstants.swiss721Family),
      ),

      // input decoration theme (text form field)
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorManager.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorManager.grey),
          ),
          hintStyle: getRegularStyle(
              fontFamily: FontConstants.swiss721Family,
              fontSize: FontSize.s14,
              color: ColorManager.grey))
      // label style
      );
}
