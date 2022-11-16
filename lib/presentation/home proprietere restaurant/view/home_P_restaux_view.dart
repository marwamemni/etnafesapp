// ignore_for_file: file_names

import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/di.dart';
import '../../common/common widgets/custom_add_card_widget.dart';
import '../../common/common widgets/custom_proprietere_card_widget.dart';
import '../../common/common widgets/loading_widget.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../view_model/home_P_restaux_viewmodel.dart';

class HomePRestauxView extends StatefulWidget {
  const HomePRestauxView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePRestauxViewState createState() => _HomePRestauxViewState();
}

class _HomePRestauxViewState extends State<HomePRestauxView> {
  final HomePRestauxViewModel _viewModel = instance<HomePRestauxViewModel>();

  _bind() {
    _viewModel.start(); // tell viewmodel, start ur job
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorManager.white,
        body: _getContentWidget(size));
  }

  Widget _getContentWidget(Size size) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customAppBar(),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p40, vertical: AppPadding.p12),
              child: Text(
                "Voilà, vos  Restaurants",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p4),
                  child: StreamBuilder<List<Restaurant>>(
                      stream: _viewModel.outputRestaux,
                      builder: (context, snapshot) {
                        List<Restaurant>? restaux;
                        if (snapshot.hasData) {
                          restaux = snapshot.data!;
                        }
                        if (restaux != null) {
                          return ListView.builder(
                              itemCount: restaux.length + 1,
                              itemBuilder: (context, index) {
                                return index == restaux!.length
                                    ? getCustomAddCardWidget(() {
                                        Navigator.pushReplacementNamed(
                                            context, Routes.addRestaurantRoute);
                                      },
                                        margin:
                                            const EdgeInsets.all(AppMargin.m30))
                                    : getCustomProprietereCardWidget(
                                        restaux[index].name,
                                        restaux[index].photoCoverture, () {
                                        Navigator.pushNamed(context,
                                            Routes.restaurantsDetailsRoute,
                                            arguments:
                                                ElementId(restaux![index].id));
                                      }, () async {
                                        await _viewModel.deleteRestaurant(
                                            restaux![index].id);
                                      }, () {
                                        Navigator.pushReplacementNamed(
                                            context, Routes.editRestaurantRoute,
                                            arguments:
                                                ElementId(restaux![index].id));
                                      },
                                        margin: index == 0
                                            ? const EdgeInsets.only(
                                                left: AppMargin.m30,
                                                right: AppMargin.m30,
                                                bottom: AppMargin.m30,
                                              )
                                            : const EdgeInsets.all(
                                                AppMargin.m30));
                              });
                        } else {
                          return loadingWidget();
                        }
                      })),
            )
          ],
        ),
      ),
    );
  }

  Row _customAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        user.userType == UserType.visiteur.name
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.registerRoute);
                    },
                    icon: SvgPicture.asset(ImageAssets.profilIcon),
                  ),
                  Text(
                    "creer compte ici",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    iconSize: AppSize.s50,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.profilRoute);
                    },
                    icon: CircleAvatar(
                      backgroundColor: ColorManager.grey,
                      radius: AppSize.s25,
                      child: CircleAvatar(
                          backgroundColor: ColorManager.white,
                          radius: AppSize.s23_5,
                          foregroundImage: NetworkImage(user.photo)),
                    ),
                  ),
                  Text(
                    "Salut ${user.firstName},",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
        if (user.userType != UserType.visiteur.name)
          IconButton(
              iconSize: AppSize.s50,
              onPressed: () {
                Navigator.pushNamed(context, Routes.notificationRoute);
              },
              icon: Stack(
                children: [
                  Center(
                      child: SvgPicture.asset(
                    ImageAssets.notificationIcon,
                    height: AppSize.s45,
                    width: 45,
                  )),
                  const Center(
                      child: Icon(
                    Icons.notifications_none_outlined,
                    size: AppSize.s30,
                  ))
                ],
              ))
      ],
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
