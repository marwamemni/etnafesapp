import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/font_manager.dart';
import 'package:agence_voyage/presentation/resources/styles_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

Widget getCustomProprietereCardWidget(String title, String url,
    void Function() fun, void Function() removeFun, void Function() editFun,
    {int? nbrPlace, double? prix, EdgeInsetsGeometry? margin}) {
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
              child: ClipRRect(
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: AppSize.s45,
            child: Padding(
              padding: const EdgeInsets.only(left: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: getRegularStyle(
                                fontFamily: FontConstants.swiss721Family,
                                fontSize: FontSize.s20,
                                color: ColorManager.black),
                          ),
                        ),
                        if (nbrPlace != null)
                          Padding(
                            padding:
                                const EdgeInsets.only(left: AppPadding.p16),
                            child: Text(
                              "$nbrPlace place disp",
                              style: getRegularStyle(
                                  fontFamily: FontConstants.swiss721Family,
                                  fontSize: FontSize.s15,
                                  color: ColorManager.grey),
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        removeFun();
                      },
                      icon: CircleAvatar(
                          child: Icon(
                        Icons.delete,
                        color: ColorManager.white,
                        size: AppSize.s16,
                      ))),
                  IconButton(
                      onPressed: () {
                        editFun();
                      },
                      icon: CircleAvatar(
                          child: Icon(
                        Icons.mode,
                        color: ColorManager.white,
                        size: AppSize.s16,
                      ))),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
