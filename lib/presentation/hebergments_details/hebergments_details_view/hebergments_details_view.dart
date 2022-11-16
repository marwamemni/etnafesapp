// ignore_for_file: use_build_context_synchronously

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_divider_line.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/dateButton.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/loading_widget.dart';
import 'package:agence_voyage/presentation/hebergments_details/hebergments_details_viewmodel/hebergments_details_viewmodel.dart';
import 'package:agence_voyage/presentation/resources/assets_manager.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HebergmentDetailsView extends StatefulWidget {
  const HebergmentDetailsView({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<HebergmentDetailsView> createState() => _HebergmentDetailsViewState();
}

class _HebergmentDetailsViewState extends State<HebergmentDetailsView> {
  final HebergmentDetailsViewModel _viewModel =
      instance<HebergmentDetailsViewModel>();
  DateTime? dateDebut;
  DateTime? dateFin;
  final List<String> categories = ['Indiv', 'Deux', 'Trois', 'Suit'];
  List<int> reservedQuantity = [
    0,
    0,
    0,
    0,
  ];
  int nbrPers = 0;
  int nbrChambreTotal = 0;
  int selectedCategorie = 0;
  double prix = 0;
  _bind() async {
    await _viewModel.getheberg(widget.id);
    // Timer.periodic(const Duration(milliseconds: 300), (t) {
    //   if (isKeyBoardOpened != MediaQuery.of(context).viewInsets.bottom > 0) {
    //     setState(() {
    //       isKeyBoardOpened = MediaQuery.of(context).viewInsets.bottom > 0;
    //     });
    //   }
    // });
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
              child: StreamBuilder<Hebergment>(
                  stream: _viewModel.outputheberg,
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapShot.data!.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                    ),
                                    GestureDetector(
                                      onTap: (() =>
                                          _viewModel.showPositionInMap(
                                              snapShot.data?.latitude,
                                              snapShot.data?.longitude)),
                                      child: Container(
                                        height: AppSize.s60,
                                        width: AppSize.s45,
                                        padding:
                                            const EdgeInsets.all(AppPadding.p8),
                                        decoration: BoxDecoration(
                                            color: ColorManager.orangeclair,
                                            borderRadius: BorderRadius.circular(
                                                AppSize.s15)),
                                        child: SvgPicture.asset(
                                          ImageAssets.mapIcon,
                                          color: ColorManager.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                "Description",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              divider(),
                              Padding(
                                padding: const EdgeInsets.all(AppPadding.p8),
                                child: Text(
                                  snapShot.data!.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: ColorManager.black),
                                ),
                              ),
                              divider(),
                              const SizedBox(
                                height: AppSize.s30,
                              ),
                              Text(
                                "Photos",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(
                                height: AppSize.s20,
                              ),
                              _getPhotosWidget(snapShot.data!.photos),
                              _getInfoWidget(snapShot.data!),
                              divider(),
                              if (user.userType == UserType.voyageur.name)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: AppPadding.p8),
                                      child: Text(
                                        'Reservation',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: ColorManager.black,
                                            ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        getDateButton(
                                          context,
                                          "DE",
                                          (date) {
                                            dateDebut = date;
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        getDateButton(
                                          context,
                                          "A",
                                          (date) {
                                            dateFin = date;
                                          },
                                        ),
                                      ],
                                    ),
                                    _getCatgorieChoise(size),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: AppPadding.p8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Prix total :',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                  color: ColorManager.black,
                                                ),
                                          ),
                                          StreamBuilder<void>(
                                              stream: _viewModel
                                                  .outputCatgorieSectionChanged,
                                              builder: (context, snapshot) {
                                                int days = 1;
                                                if (dateDebut != null &&
                                                    dateFin != null) {
                                                  days = dateFin!
                                                          .difference(
                                                              dateDebut!)
                                                          .inDays +
                                                      1;
                                                }
                                                double prixTotal = days *
                                                    (reservedQuantity[0] *
                                                            snapShot.data!
                                                                .prixChambreIndiv +
                                                        reservedQuantity[1] *
                                                            snapShot.data!
                                                                .prixChambreDeux +
                                                        reservedQuantity[2] *
                                                            snapShot.data!
                                                                .prixChambreTrois +
                                                        reservedQuantity[3] *
                                                            snapShot.data!
                                                                .prixSuit);
                                                prix = prixTotal;
                                                for (int i = 0;
                                                    i < reservedQuantity.length;
                                                    i++) {
                                                  nbrChambreTotal +=
                                                      reservedQuantity[i];
                                                }
                                                for (int i = 0;
                                                    i < reservedQuantity.length;
                                                    i++) {
                                                  nbrPers +=
                                                      (reservedQuantity[i] *
                                                          (i + 1));
                                                }
                                                return Text(
                                                  '\$ $prixTotal',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                        color:
                                                            ColorManager.black,
                                                      ),
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: (() async {
                                            if (user.points >= prix &&
                                                dateDebut != null &&
                                                dateFin != null &&
                                                snapShot.data!.dateDebut
                                                    .isBefore(dateDebut!) &&
                                                snapShot.data!.dateFin
                                                    .isAfter(dateFin!) &&
                                                nbrPers > 0 &&
                                                nbrPers <=
                                                    snapShot
                                                        .data!.nbrPlaceDisp &&
                                                nbrChambreTotal <=
                                                    snapShot
                                                        .data!.nbrChambreDisp &&
                                                reservedQuantity[0] <=
                                                    snapShot.data!
                                                        .nbrChambreIndiv &&
                                                reservedQuantity[1] <=
                                                    snapShot
                                                        .data!.nbrChambreDeux &&
                                                reservedQuantity[2] <=
                                                    snapShot.data!
                                                        .nbrChambreTrois &&
                                                reservedQuantity[3] <=
                                                    snapShot.data!.nbrSuit) {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => Dialog(
                                                      insetPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      backgroundColor:
                                                          ColorManager.black
                                                              .withOpacity(
                                                                  AppOpacity
                                                                      .o05),
                                                      child: loadingWidget()));
                                              await _viewModel.postReservaton(
                                                snapShot.data!,
                                                dateDebut!,
                                                dateFin!,
                                                prix,
                                                nbrPers,
                                                nbrChambreTotal,
                                                reservedQuantity,
                                              );
                                              Navigator.pop(context);
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => const Dialog(
                                                        child: Text(
                                                            "Check your inputs"),
                                                      ));
                                            }
                                          }),
                                          icon: SvgPicture.asset(
                                            ImageAssets.checkIcon,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return loadingWidget();
                    }
                  }),
            )),
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

  Widget _getInfoWidget(Hebergment hebergment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: StreamBuilder<bool>(
          stream: _viewModel.outputIsInfoOpen,
          builder: (context, snapshot) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (snapshot.data ?? false) {
                      _viewModel.inputIsInfoOpen.add(false);
                    } else {
                      _viewModel.inputIsInfoOpen.add(true);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "more info",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Icon(
                        (snapshot.data ?? false)
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: ColorManager.grey,
                        size: AppSize.s50,
                      )
                    ],
                  ),
                ),
                if (snapshot.data ?? false)
                  SizedBox(
                    child: Column(
                      children: [
                        _textCustom(hebergment.categorie, 'type'),
                        _textCustom(
                            '${hebergment.dateDebut.year}:${hebergment.dateDebut.month}:${hebergment.dateDebut.day}',
                            'De'),
                        _textCustom(
                            '${hebergment.dateFin.year}:${hebergment.dateFin.month}:${hebergment.dateFin.day}',
                            'A'),
                        _textCustom(hebergment.nbrChambreIndiv.toString(),
                            "Chambre a Indiv"),
                        _textCustom(hebergment.nbrChambreDeux.toString(),
                            'Chambre a Deux'),
                        _textCustom(hebergment.nbrChambreTrois.toString(),
                            'Chambre a Trois'),
                        _textCustom(hebergment.nbrSuit.toString(), 'Suits'),
                        // _textCustom(hebergment.nbrPlaceDisp.toString(),
                        //     'Place Disponible'),
                        _textCustom(hebergment.prixChambreIndiv.toString(),
                            'Prix Indiv'),
                        _textCustom(hebergment.prixChambreDeux.toString(),
                            'Prix a Deux'),
                        _textCustom(hebergment.prixChambreTrois.toString(),
                            'Prix a Trois'),
                        _textCustom(
                            hebergment.prixSuit.toString(), 'Prix de Suit'),
                      ],
                    ),
                  )
              ],
            );
          }),
    );
  }

  Widget _textCustom(String body, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title:',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          body,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: ColorManager.black, fontSize: 13.5),
        ),
      ],
    );
  }

  Widget _getCatgorieChoise(Size size) {
    return StreamBuilder<void>(
        stream: _viewModel.outputCatgorieSectionChanged,
        builder: (context, snapshot) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Chambre:",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: ColorManager.black),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      height: 30,
                      width: size.width - 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.5),
                              child: GestureDetector(
                                onTap: () {
                                  selectedCategorie = index;

                                  _viewModel.inputCatgorieSectionChanged
                                      .add(null);
                                },
                                child: Container(
                                  height: 30,
                                  width: 112,
                                  decoration: BoxDecoration(
                                    color: (index == selectedCategorie)
                                        ? ColorManager.orange
                                        : ColorManager.grey,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      categories[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: ColorManager.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "pour:",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: ColorManager.black),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (reservedQuantity[selectedCategorie] > 0) {
                                reservedQuantity[selectedCategorie]--;

                                _viewModel.inputCatgorieSectionChanged
                                    .add(null);
                              }
                            },
                            child: Container(
                              height: AppSize.s25,
                              width: AppSize.s25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: reservedQuantity[selectedCategorie] > 0
                                    ? ColorManager.orange
                                    : ColorManager.grey,
                              ),
                              child: Icon(
                                Icons.remove,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width / 30,
                          ),
                          Text(reservedQuantity[selectedCategorie].toString(),
                              style: Theme.of(context).textTheme.bodySmall),
                          SizedBox(
                            width: size.width / 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              reservedQuantity[selectedCategorie]++;

                              _viewModel.inputCatgorieSectionChanged.add(null);
                            },
                            child: Container(
                              height: AppSize.s25,
                              width: AppSize.s25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorManager.orange,
                              ),
                              child: Icon(
                                Icons.add,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
