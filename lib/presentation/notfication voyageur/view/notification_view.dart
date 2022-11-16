// ignore_for_file: use_build_context_synchronously

import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/loading_widget.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/notification_widget.dart';
import 'package:agence_voyage/presentation/notfication%20voyageur/view%20model/notification_voyageur_viewmodel.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/font_manager.dart';
import 'package:agence_voyage/presentation/resources/styles_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/di.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';

class NotificationVoyageurView extends StatefulWidget {
  const NotificationVoyageurView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotificationVoyageurViewState createState() =>
      _NotificationVoyageurViewState();
}

class _NotificationVoyageurViewState extends State<NotificationVoyageurView> {
  final NotificationVoyageurViewModel _viewModel =
      instance<NotificationVoyageurViewModel>();
  bool isLoading = false;
  Paye? paye;
  Ville? ville;
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
        backgroundColor: ColorManager.orangeclair,
        appBar: AppBar(
          title: Text(
            "Vos notification",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          backgroundColor: ColorManager.orangeclair,
          leading: IconButton(
            onPressed: (() {
              if (user.userType == UserType.voyageur.name) {
                Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
              } else if (user.userType == UserType.adminAgence.name) {
                Navigator.of(context)
                    .pushReplacementNamed(Routes.homeAdminRoute);
              } else if (user.userType == UserType.prorietereResto.name) {
                Navigator.of(context)
                    .pushReplacementNamed(Routes.homeProprieterRestauRoute);
              } else if (user.userType == UserType.prorietereHeberg.name) {
                Navigator.of(context)
                    .pushReplacementNamed(Routes.homeHebergerRoute);
              }
            }),
            icon: SvgPicture.asset(ImageAssets.backIcon),
          ),
        ),
        body: _getContentWidget(size));
  }

  Widget _getContentWidget(Size size) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: StreamBuilder<List<Reservation>>(
              stream: _viewModel.outputnotification,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return getNotification(snapshot.data![index], () async {
                          showDialog(
                              context: context,
                              builder: (_) => loadingWidget());
                          await _viewModel
                              .getClient(snapshot.data![index].userId);
                          Navigator.pop(context);
                          if (_viewModel.client != null) {
                            showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                      child: SizedBox(
                                        width: AppSize.s200,
                                        height: 300,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: AppPadding.p4),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            AppPadding.p12,
                                                        vertical:
                                                            AppPadding.p20),
                                                child: Text("Contacter ",
                                                    style: getBoldStyle(
                                                        color: ColorManager
                                                            .bleuFonce,
                                                        fontFamily: FontConstants
                                                            .stikaHeadingFamily,
                                                        fontSize: 35)),
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    _viewModel.client!.email,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                  Container(
                                                    height: 0.3,
                                                    width: double.infinity,
                                                    color: ColorManager.grey,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  SelectableText(
                                                    _viewModel.client!.phone,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                  Container(
                                                    height: 0.3,
                                                    width: double.infinity,
                                                    color: ColorManager.grey,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                loadingWidget());
                                                        await _viewModel
                                                            .confirmeNotification(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .id);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Confirmer',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineLarge,
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                          }
                        });
                      });
                } else {
                  return loadingWidget();
                }
              })),
    );
  }
}
