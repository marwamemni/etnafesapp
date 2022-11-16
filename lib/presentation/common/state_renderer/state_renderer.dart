import 'package:agence_voyage/presentation/resources/assets_manager.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/font_manager.dart';
import 'package:agence_voyage/presentation/resources/styles_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  // POPUP STATES (DIALOG)
  popupLoadingState,
  popupErrorState,
  popupSuccess,
}

Widget getStateWidget(BuildContext context, StateRendererType stateRendererType,
    {String message = '', String title = ''}) {
  switch (stateRendererType) {
    case StateRendererType.popupLoadingState:
      return _getPopUpDialog(context, [_getAnimatedImage(JsonAssets.loading)]);
    case StateRendererType.popupErrorState:
      return _getPopUpDialog(context, [
        _getAnimatedImage(JsonAssets.error),
        _getMessage(message),
        _getRetryButton('ok', context)
      ]);
    case StateRendererType.popupSuccess:
      return _getPopUpDialog(context, [
        _getAnimatedImage(JsonAssets.success),
        _getMessage(title),
        _getMessage(message),
        _getRetryButton('ok', context)
      ]);
    default:
      return Container();
  }
}

Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14)),
    elevation: AppSize.s1_5,
    backgroundColor: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(color: Colors.black26)]),
      child: _getDialogContent(context, children),
    ),
  );
}

Widget _getDialogContent(BuildContext context, List<Widget> children) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: children,
  );
}

Widget _getAnimatedImage(String animationName) {
  return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName));
}

Widget _getMessage(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Text(
        message,
        style:
            getRegularStyle(color: ColorManager.black, fontSize: FontSize.s18),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _getRetryButton(String buttonTitle, BuildContext context,
    [Function? function]) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppPadding.p18),
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                // popup error state
                if (function != null) {
                  function();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(buttonTitle))),
    ),
  );
}
