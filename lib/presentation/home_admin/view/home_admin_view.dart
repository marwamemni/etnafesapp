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
import '../view_model/home_admin_viewmodel.dart';

class HomeAdminView extends StatefulWidget {
  const HomeAdminView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeAdminViewState createState() => _HomeAdminViewState();
}

class _HomeAdminViewState extends State<HomeAdminView> {
  final HomeAdminViewModel _viewModel = instance<HomeAdminViewModel>();

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
                "Voilà, Les packs créés",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p4),
                  child: StreamBuilder<List<Pack>>(
                      stream: _viewModel.outputpacks,
                      builder: (context, snapshot) {
                        List<Pack>? packs;
                        if (snapshot.hasData) {
                          packs = snapshot.data!;
                        }
                        if (packs != null) {
                          return ListView.builder(
                              itemCount: packs.length + 1,
                              itemBuilder: (context, index) {
                                return index == packs!.length
                                    ? getCustomAddCardWidget(() {
                                        Navigator.pushReplacementNamed(
                                            context, Routes.addAdminRoute);
                                      },
                                        margin:
                                            const EdgeInsets.all(AppMargin.m30))
                                    : getCustomProprietereCardWidget(
                                        packs[index].name,
                                        packs[index].photoCoverture, () {
                                        Navigator.pushNamed(
                                            context, Routes.packsDetailsRoute,
                                            arguments:
                                                ElementId(packs![index].id));
                                      }, () async {
                                        await _viewModel
                                            .deletePack(packs![index].id);
                                      }, () {
                                        Navigator.pushReplacementNamed(
                                            context, Routes.editAdminRoute,
                                            arguments:
                                                ElementId(packs![index].id));
                                      },
                                        nbrPlace: packs[index].nbrPlaceDisp,
                                        prix: packs[index].prix,
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
