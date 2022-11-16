import 'dart:math';

import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/custom_card_widget.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/drop_down_button.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/loading_widget.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/search_bar.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/routes_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:agence_voyage/presentation/restaurants_voyager/viewmodel/restaurants_voyageur_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/di.dart';
import '../../resources/assets_manager.dart';

class RestaurantsVoyageurView extends StatefulWidget {
  const RestaurantsVoyageurView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RestaurantsVoyageurViewState createState() =>
      _RestaurantsVoyageurViewState();
}

class _RestaurantsVoyageurViewState extends State<RestaurantsVoyageurView> {
  final RestaurantsVoyageurViewModel _viewModel =
      instance<RestaurantsVoyageurViewModel>();
  bool isLoading = false;
  Paye? paye;
  Ville? ville;
  List<Restaurant>? restaurants;
  String searchQuery = '';
  _bind() {
    _viewModel.start();
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
        backgroundColor: ColorManager.white, body: _getContentWidget(size));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _getContentWidget(Size size) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          bottom: -50,
          height: size.height + 100,
          width: size.width,
          child: Image.asset(
            ImageAssets.restaurantsCover,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 210,
            left: 30,
            child: Text(
              "Meilleurs Restaurants",
              style: Theme.of(context).textTheme.headlineLarge,
            )),
        Positioned(
          top: 240,
          height: size.height - 230,
          width: size.width,
          child: Padding(
              padding: const EdgeInsets.all(AppPadding.p4),
              child: StreamBuilder<List<Restaurant>>(
                  stream: _viewModel.outputRestaurants,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      restaurants = snapshot.data!;
                    }
                    if (restaurants != null) {
                      return ListView.builder(
                          itemCount: restaurants!.length,
                          itemBuilder: (context, index) {
                            return getCustomCardWidget(restaurants![index].name,
                                restaurants![index].photoCoverture, () {
                              if (user.userType == UserType.adminAgence.name) {
                                Navigator.of(context).pop(restaurants![index]);
                              } else {
                                Navigator.pushNamed(
                                    context, Routes.restaurantsDetailsRoute,
                                    arguments:
                                        ElementId(restaurants![index].id));
                              }
                            },
                                margin: index == 0
                                    ? const EdgeInsets.only(
                                        left: AppMargin.m30,
                                        right: AppMargin.m30,
                                        bottom: AppMargin.m30,
                                      )
                                    : const EdgeInsets.all(AppMargin.m30));
                          });
                    } else {
                      return loadingWidget();
                    }
                  })),
        ),
        Positioned(
          top: 80,
          height: size.height,
          width: size.width,
          child: getSearchBar(
              size,
              context,
              (context, s) => SizedBox(
                    height: size.height - 200,
                    child: StreamBuilder<List<Restaurant>>(
                        stream: _viewModel.outputRestaurants,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            restaurants = snapshot.data!;
                          }
                          List<Restaurant> searchRestaurants =
                              restaurants ?? [];
                          searchRestaurants = searchRestaurants
                              .where((element) =>
                                  element.name.contains(searchQuery))
                              .toList();
                          return ListView.builder(
                              itemCount: searchRestaurants.length,
                              itemBuilder: (context, index) {
                                return getCustomCardWidget(
                                    searchRestaurants[index].name,
                                    searchRestaurants[index].photoCoverture,
                                    () {
                                  Navigator.pushNamed(
                                      context, Routes.restaurantsDetailsRoute,
                                      arguments: ElementId(
                                          searchRestaurants[index].id));
                                },
                                    margin: index == 0
                                        ? const EdgeInsets.only(
                                            left: AppMargin.m30,
                                            right: AppMargin.m30,
                                            bottom: AppMargin.m30,
                                          )
                                        : const EdgeInsets.all(AppMargin.m30));
                              });
                        }),
                  ),
              (quary) => searchQuery = quary),
        ),
        Positioned(top: 0, child: _getFilterAppBar(size))
      ],
    );
  }

  Widget _getFilterAppBar(Size size) {
    return StreamBuilder<bool>(
        stream: _viewModel.outputIsFilterOpened,
        builder: (context, snapshot) {
          if (!(snapshot.data ?? false)) {
            return Container(
              height: AppSize.s100,
              width: size.width,
              decoration: BoxDecoration(
                  color: ColorManager.bleuFonce,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(AppSize.s20),
                      bottomRight: Radius.circular(AppSize.s20))),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: (() => Navigator.pop(context)),
                      icon: SvgPicture.asset(
                        ImageAssets.backIcon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppPadding.p8, right: AppPadding.p60 * 2),
                      child: Text(
                        "Restaurants",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    IconButton(
                      onPressed: (() async {
                        _viewModel.inputIsFilterOpened.add(true);
                        await _viewModel.getPays();
                      }),
                      icon: Container(
                        padding: const EdgeInsets.all(AppPadding.p2),
                        decoration: BoxDecoration(
                            color: ColorManager.orangeclair,
                            borderRadius: BorderRadius.circular(9)),
                        child: Icon(
                          Icons.tune,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return _getFilterWidget(size, context);
          }
        });
  }

  Container _getFilterWidget(Size size, BuildContext context) {
    return Container(
      height: size.height * 0.6,
      width: size.width,
      decoration: BoxDecoration(
          color: ColorManager.bleuFonce,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(AppSize.s100),
              bottomRight: Radius.circular(AppSize.s100))),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p4),
        child: Padding(
          padding:
              const EdgeInsets.only(left: AppPadding.p50, top: AppPadding.p50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filtres',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p20, right: AppPadding.p50 * 2),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsFilterUpdated,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          getDropDownButton<Paye>('', _viewModel.outputPays,
                              (value) {
                            paye = value;
                            ville = null;
                            if (value != null) {
                              _viewModel.setPaye(value.id);
                            }
                            _viewModel.inputIsFilterOpened.add(true);
                          }, paye, context, "Paye"),
                          getDropDownButton<Ville>('', _viewModel.outputvilles,
                              (value) {
                            ville = value;
                            if (value != null) {
                              _viewModel.setVille(value.id);
                            }
                          }, ville, context, "Ville"),
                          const SizedBox(
                            height: AppSize.s15,
                          ),
                        ],
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p20 * 2, right: AppPadding.p50 * 2 + 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: (() => Navigator.pop(context)),
                      icon: SvgPicture.asset(
                        ImageAssets.backIcon,
                      ),
                    ),
                    IconButton(
                      onPressed: (() =>
                          _viewModel.inputIsFilterOpened.add(false)),
                      icon: Transform(
                        transform: Matrix4.rotationZ(pi / 2),
                        origin: const Offset(15, 15),
                        child: SvgPicture.asset(
                          ImageAssets.backIcon,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (() {
                        _viewModel.inputIsFilterOpened.add(false);
                        _viewModel.getRestaurants(ville: ville);
                      }),
                      icon: SvgPicture.asset(
                        ImageAssets.checkIcon,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
