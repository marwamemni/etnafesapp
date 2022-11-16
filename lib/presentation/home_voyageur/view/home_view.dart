import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/common/state_renderer/state_renderer.dart';
import 'package:agence_voyage/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:agence_voyage/presentation/home_voyageur/viewmodel/home_viewmodel.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/di.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();
  bool isLoading = false;
  Paye? paye;
  Ville? ville;
  _bind() {
    _viewModel.start(); // tell viewmodel, start ur job
    _viewModel.outputState.listen((event) {
      //TODO
      if (event != null) {
        if (event.getStateRendererType() ==
            StateRendererType.popupLoadingState) {
          showPopup(context, event.getStateRendererType(), "");
          isLoading = true;
        } else if (isLoading && Navigator.canPop(context)) {
          Navigator.pop(context);
          isLoading = false;
        }
      }
    });
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
                  horizontal: AppPadding.p20, vertical: AppPadding.p12),
              child: Text(
                "Profitez de vos vaccances!",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            StreamBuilder<void>(
                stream: _viewModel.outputDropDownValueChange,
                builder: (context, snapshot) {
                  return Column(children: [
                    _dropDownWidget<Paye>("pays", _viewModel.outputPays,
                        (value) {
                      ville = null;
                      paye = value;
                      if (value != null) {
                        _viewModel.setPaye(value.id);
                      }
                      _viewModel.inputDropDownValueChange.add(null);
                    }, paye),
                    _dropDownWidget<Ville>("villes", _viewModel.outputvilles,
                        (value) {
                      ville = value;
                      if (value != null) {
                        _viewModel.setVille(value.id);
                      }
                      _viewModel.inputDropDownValueChange.add(null);
                    }, ville),
                  ]);
                }),
            _serviceChoiseWidget(size),
            Text(
              "Populaire",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            _offersWidget(),
            // IconButton(
            //     onPressed: () {
            //       Navigator.pushReplacementNamed(context, Routes.splashRoute);
            //     },
            //     icon: Icon(Icons.back_hand)),
            // Text(user.userType)
          ],
        ),
      ),
    );
  }

  SizedBox _offersWidget() => const SizedBox(
        height: 200,
      );

  Row _serviceChoiseWidget(Size size) {
    return Row(
      children: [
        _getChoise(Routes.restaurantsVoyageurRoute,
            ImageAssets.restaurantsChoise, size),
        _getChoise(
            Routes.hebergmentVoyageurRoute, ImageAssets.hebergmentChoise, size),
        _getChoise(Routes.packsVoyageurRoute, ImageAssets.packsChoise, size),
      ],
    );
  }

  Widget _dropDownWidget<Obj>(String title, Stream<List<Obj>>? stream,
      void Function(Obj?)? onChanged, Obj? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Flex(direction: Axis.vertical, children: [
        Container(
          height: AppSize.s45,
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s25),
            border: Border.all(
                color: ColorManager.grey,
                style: BorderStyle.solid,
                width: AppSize.s0_5),
          ),
          child: StreamBuilder<List<Obj>>(
              stream: stream,
              builder: (context, snapshot) {
                return DropdownButton<Obj>(
                  iconEnabledColor: ColorManager.orangeclair,
                  key: Key(Obj.runtimeType.toString()),
                  style: Theme.of(context).textTheme.titleSmall,
                  underline: const SizedBox(),
                  iconSize: AppSize.s30,
                  disabledHint: const SizedBox(),
                  isExpanded: true,
                  hint: Container(
                    color: ColorManager.white,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  value:
                      value, // this place should not have a controller but a variable
                  onChanged: onChanged,
                  items: snapshot.hasData
                      ? snapshot.data!
                          .map<
                              DropdownMenuItem<
                                  Obj>>((Obj val) => DropdownMenuItem<Obj>(
                              value:
                                  val, // add this property an pass the _value to it
                              child: Text(
                                val.toString(),
                              )))
                          .toList()
                      : null,
                );
              }),
        ),
      ]),
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
                    "Salut ${user.firstName}",
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

  Widget _getChoise(String route, String asset, Size size) {
    return IconButton(
        iconSize: (size.width - AppPadding.p20 * 2) / 3,
        padding: const EdgeInsets.all(0),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        icon: Image.asset(
          asset,
          fit: BoxFit.fill,
        ));
  }
}
