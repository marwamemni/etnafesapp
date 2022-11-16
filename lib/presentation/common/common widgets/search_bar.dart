import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

Widget getSearchBar(
    Size size,
    BuildContext context,
    Widget Function(BuildContext, Animation<double>) builder,
    Function(String)? onQueryChanged) {
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  return FloatingSearchBar(
    backgroundColor: ColorManager.white,
    borderRadius: BorderRadius.circular(AppSize.s25),
    backdropColor: ColorManager.white,
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 800),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    axisAlignment: isPortrait ? 0.0 : -1.0,
    openAxisAlignment: 0.0,
    height: AppSize.s45, //size.height - 173,
    width: isPortrait ? 600 : 500,
    debounceDelay: const Duration(milliseconds: 500),
    onQueryChanged: onQueryChanged,
    // Specify a custom transition to be used for
    // animating between opened and closed stated.
    transition: CircularFloatingSearchBarTransition(),
    leadingActions: [
      FloatingSearchBarAction.hamburgerToBack(),
    ],
    automaticallyImplyBackButton: false,

    actions: const [],
    builder: builder,
  );
}
