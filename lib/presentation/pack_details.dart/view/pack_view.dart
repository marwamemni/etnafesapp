// ignore_for_file: use_build_context_synchronously

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_divider_line.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/loading_widget.dart';
import 'package:agence_voyage/presentation/pack_details.dart/view_model/pack_viewmodel.dart';
import 'package:agence_voyage/presentation/resources/assets_manager.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/routes_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PackDetailsView extends StatefulWidget {
  const PackDetailsView({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<PackDetailsView> createState() => _PackDetailsViewState();
}

class _PackDetailsViewState extends State<PackDetailsView> {
  final PackDetailsViewModel _viewModel = instance<PackDetailsViewModel>();

  final TextEditingController _nbrPersonne = TextEditingController();
  int nbrPers = 0;

  _bind() async {
    await _viewModel.getPack(widget.id);
    _nbrPersonne.addListener(() {
      try {
        nbrPers = double.parse(_nbrPersonne.text).toInt();
      } catch (_) {}
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
            ImageAssets.hebergmentDetailsCover,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: AppSize.s40,
          left: AppSize.s30,
          child: IconButton(
            onPressed: (() => Navigator.pop(context)),
            icon: SvgPicture.asset(
              ImageAssets.backIcon,
            ),
          ),
        ),
        Positioned(
            top: AppSize.s90,
            left: AppSize.s30,
            child: Container(
              height: size.height - AppSize.s110,
              width: size.width - AppSize.s60,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(AppOpacity.o07),
                  borderRadius: BorderRadius.circular(AppSize.s16)),
              child: StreamBuilder<Pack>(
                  stream: _viewModel.outputPack,
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      return Column(
                        children: [
                          _getHeaderWidget(snapShot),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p20),
                              child: SingleChildScrollView(
                                child: StreamBuilder<bool>(
                                    stream: _viewModel.outputIsActiviteOpen,
                                    builder: (context, isActiviteOpen) {
                                      _viewModel.start();
                                      return (isActiviteOpen.data ?? true)
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Description",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                                divider(),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      AppPadding.p8),
                                                  child: Text(
                                                    snapShot.data!.description,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                            color: ColorManager
                                                                .black),
                                                  ),
                                                ),
                                                divider(),
                                                const SizedBox(
                                                  height: AppSize.s30,
                                                ),
                                                Text(
                                                  "Activites",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                                const SizedBox(
                                                  height: AppSize.s20,
                                                ),
                                                _getInfoWidget(
                                                    snapShot.data!.activites),
                                                divider(),
                                                const SizedBox(
                                                  height: AppSize.s30,
                                                ),
                                                Text(
                                                  "Photos",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                                const SizedBox(
                                                  height: AppSize.s20,
                                                ),
                                                _getPhotosWidget(
                                                    snapShot.data!.photos),
                                                //    _getInfoWidget(snapShot.data!),
                                                divider(),
                                              ],
                                            )
                                          : Column(children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Hebergments",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                  StreamBuilder<
                                                          List<Hebergment>>(
                                                      stream: _viewModel
                                                          .outputhebergs,
                                                      builder:
                                                          (context, hebergs) {
                                                        if (hebergs.hasData) {
                                                          return CarouselSlider(
                                                              items: hebergs
                                                                  .data!
                                                                  .map((heb) =>
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).pushNamed(Routes.hebergmentDetailsRoute,
                                                                                arguments: ElementId(heb.id));
                                                                          },
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                height: (size.width - AppSize.s80) * 0.65625 - 20,
                                                                                width: size.width - AppSize.s80,
                                                                                decoration: BoxDecoration(
                                                                                  border: Border.all(color: ColorManager.white, width: 1),
                                                                                ),
                                                                                child: Image.network(
                                                                                  heb.photoCoverture,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                heb.name,
                                                                                style: Theme.of(context).textTheme.titleSmall,
                                                                              ),
                                                                            ],
                                                                          )))
                                                                  .toList(),
                                                              options: CarouselOptions(
                                                                  height: (size.width -
                                                                              AppSize
                                                                                  .s80) *
                                                                          0.65625 +
                                                                      50,
                                                                  autoPlay:
                                                                      true,
                                                                  enableInfiniteScroll:
                                                                      true,
                                                                  enlargeCenterPage:
                                                                      true));
                                                        } else {
                                                          return Center(
                                                            child:
                                                                loadingWidget(),
                                                          );
                                                        }
                                                      }),
                                                  Text(
                                                    "Restaurants",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                  StreamBuilder<
                                                          List<Restaurant>>(
                                                      stream: _viewModel
                                                          .outputRestaux,
                                                      builder:
                                                          (context, restaux) {
                                                        if (snapShot.hasData) {
                                                          return CarouselSlider(
                                                              items: restaux
                                                                  .data!
                                                                  .map((res) =>
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).pushNamed(Routes.restaurantsDetailsRoute,
                                                                                arguments: ElementId(res.id));
                                                                          },
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                height: (size.width - AppSize.s80) * 0.65625 - 20,
                                                                                width: size.width - AppSize.s80,
                                                                                decoration: BoxDecoration(
                                                                                  border: Border.all(color: ColorManager.white, width: 1),
                                                                                ),
                                                                                child: Image.network(
                                                                                  res.photoCoverture,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                res.name,
                                                                                style: Theme.of(context).textTheme.titleSmall,
                                                                              ),
                                                                            ],
                                                                          )))
                                                                  .toList(),
                                                              options: CarouselOptions(
                                                                  height: (size.width -
                                                                              AppSize
                                                                                  .s80) *
                                                                          0.65625 +
                                                                      50,
                                                                  autoPlay:
                                                                      true,
                                                                  enableInfiniteScroll:
                                                                      true,
                                                                  enlargeCenterPage:
                                                                      true));
                                                        } else {
                                                          return Center(
                                                            child:
                                                                loadingWidget(),
                                                          );
                                                        }
                                                      }),
                                                  if (user.userType ==
                                                      UserType.voyageur.name)
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      AppPadding
                                                                          .p8),
                                                          child: Text(
                                                            'Reservation',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                  color:
                                                                      ColorManager
                                                                          .black,
                                                                ),
                                                          ),
                                                        ),
                                                        _getChampWidget(
                                                            'pour',
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .only(
                                                                  left:
                                                                      AppPadding
                                                                          .p8),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    _nbrPersonne,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .phone,
                                                                decoration: const InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    focusedBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    enabledBorder:
                                                                        InputBorder
                                                                            .none),
                                                              ),
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      AppPadding
                                                                          .p8),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Prix total :',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall
                                                                    ?.copyWith(
                                                                      color: ColorManager
                                                                          .black,
                                                                    ),
                                                              ),
                                                              Text(
                                                                '\$ ${nbrPers * snapShot.data!.prix}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall
                                                                    ?.copyWith(
                                                                      color: ColorManager
                                                                          .black,
                                                                    ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            IconButton(
                                                              onPressed:
                                                                  (() async {
                                                                if (nbrPers >
                                                                        0 &&
                                                                    user.points >=
                                                                        (nbrPers *
                                                                            snapShot.data!.prix)) {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder: (_) => Dialog(
                                                                          insetPadding: const EdgeInsets.all(
                                                                              0),
                                                                          backgroundColor: ColorManager.black.withOpacity(AppOpacity
                                                                              .o05),
                                                                          child:
                                                                              loadingWidget()));
                                                                  await _viewModel
                                                                      .postReservaton(
                                                                    snapShot
                                                                        .data!,
                                                                    nbrPers,
                                                                  );
                                                                  Navigator.pop(
                                                                      context);
                                                                } else {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) =>
                                                                              const Dialog(
                                                                                child: Text("Check your inputs"),
                                                                              ));
                                                                }
                                                              }),
                                                              icon: SvgPicture
                                                                  .asset(
                                                                ImageAssets
                                                                    .checkIcon,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 500,
                                                        )
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ]);
                                    }),
                              ),
                            ),
                          ),
                          _getBottomWidget(snapShot)
                        ],
                      );
                    } else {
                      return loadingWidget();
                    }
                  }),
            )),
      ],
    );
  }

  Widget _getBottomWidget(AsyncSnapshot<Pack> snapShot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        divider(),
        Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p20, right: AppPadding.p20, top: AppPadding.p12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Seulement à',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: ColorManager.black,
                    ),
              ),
              Text(
                '${snapShot.data!.prix}DT',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: ColorManager.black,
                    ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              //vertical: AppPadding.p12,
              horizontal: AppPadding.p20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Appelez l'agence",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              IconButton(
                  iconSize: AppSize.s50,
                  onPressed: () async {
                    showDialog(
                        context: context, builder: (_) => loadingWidget());
                    final proprietaire = await _viewModel
                        .getProprieter(snapShot.data!.proprietaireId);
                    Navigator.of(context).pop();
                    if (proprietaire.userType == UserType.adminAgence.name) {
                      showDialog(
                          context: context,
                          builder: (_) => Dialog(
                                child: SizedBox(
                                  height: AppSize.s200,
                                  width: AppSize.s200,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SelectableText(proprietaire.email),
                                      SelectableText(proprietaire.phone)
                                    ],
                                  ),
                                ),
                              ));
                    } else {
                      showDialog(
                          context: context,
                          builder: (_) => const Dialog(
                                child: SizedBox(
                                    height: AppSize.s200,
                                    width: AppSize.s200,
                                    child: Center(child: Text('Error'))),
                              ));
                    }
                  },
                  icon: SvgPicture.asset(ImageAssets.appelIcon))
            ],
          ),
        )
      ],
    );
  }

  Column _getHeaderWidget(AsyncSnapshot<Pack> snapShot) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(
            AppPadding.p20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                snapShot.data!.name,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p20, bottom: AppPadding.p2),
                child: GestureDetector(
                  onTap: () {
                    _viewModel.inputIsActiviteOpen.add(false);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        ImageAssets.bedIcon,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: AppPadding.p2, left: AppPadding.p8),
                          child: Text(
                            'Food & Hotel',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 30,
              color: ColorManager.grey,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: AppPadding.p20, bottom: AppPadding.p2),
                child: GestureDetector(
                  onTap: () {
                    _viewModel.inputIsActiviteOpen.add(true);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: AppPadding.p8, top: AppPadding.p2),
                          child: Text(
                            'Activities',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        ImageAssets.actIcon,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        divider(),
      ],
    );
  }

  Widget _getPhotosWidget(
    List<String>? photos,
  ) {
    if (photos != null) {
      return CarouselSlider(
          items: photos
              .map((photo) => GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                insetPadding: const EdgeInsets.all(0),
                                backgroundColor:
                                    ColorManager.black.withOpacity(0.5),
                                child: _getPhotosScreen(photos,
                                    initialPage: photos.indexOf(photo)));
                          });
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: AppSize.s1_5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            side: BorderSide(
                                color: ColorManager.grey, width: AppSize.s0_5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          child: Image.network(photo, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              aspectRatio: 1.5,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true));
    } else {
      return Container();
    }
  }

  Widget _getPhotosScreen(List<String>? photos, {int initialPage = 0}) {
    if (photos != null) {
      return CarouselSlider(
          items: photos
              .map((photo) => GestureDetector(
                    onDoubleTap: () => Navigator.of(context).pop(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      child: Image.network(photo, fit: BoxFit.fitWidth),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              initialPage: initialPage,
              //    aspectRatio: 1.5,
              height: MediaQuery.of(context).size.height,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true));
    } else {
      return Container();
    }
  }

  Widget _getInfoWidget(List<String> activites) {
    return Column(
      children: [
        for (int index = 0; index < activites.length; index++)
          _textCustom(activites[index], 'act ${index + 1}'),
      ],
    );
  }

  Widget _textCustom(String body, String title) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '*',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Expanded(
            child: Text(
              body,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: ColorManager.black, fontSize: 13.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getChampWidget(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: ColorManager.black),
          ),
          const SizedBox(
            width: AppSize.s10,
          ),
          Expanded(
            child: Container(
              // width: AppSize.s150,
              height: AppSize.s27,
              decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s10),
                  border: Border.all(color: ColorManager.grey)),
              child: content,
            ),
          )
        ],
      ),
    );
  }
}
