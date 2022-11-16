// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_divider_line.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/dateButton.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/loading_widget.dart';
import 'package:agence_voyage/presentation/resources/assets_manager.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:agence_voyage/presentation/restaurant_details/view_model/restaurant_details_viewmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RestaurantDetailsView extends StatefulWidget {
  const RestaurantDetailsView({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<RestaurantDetailsView> createState() => _RestaurantDetailsViewState();
}

class _RestaurantDetailsViewState extends State<RestaurantDetailsView> {
  final RestaurantDetailsViewModel _viewModel =
      instance<RestaurantDetailsViewModel>();
  final TextEditingController _nbrPersonne = TextEditingController();
  DateTime? dateTime;
  _bind() async {
    await _viewModel.getRestaurant(widget.id);
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
          bottom: 00,
          height: size.height + 100,
          width: size.width,
          child: Image.asset(
            ImageAssets.restaurantDetailsCover,
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
              child: StreamBuilder<Restaurant>(
                  stream: _viewModel.outputRestaurant,
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
                              divider(),
                              if (user.userType == UserType.voyageur.name)
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: AppPadding.p8),
                                        child: Text(
                                          'Reservation',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          getDateButton(
                                            context,
                                            "LE",
                                            (date) {
                                              if (dateTime != null) {
                                                dateTime = DateTime(
                                                    date.year,
                                                    date.month,
                                                    date.day,
                                                    dateTime!.hour,
                                                    dateTime!.minute);
                                              } else {
                                                dateTime = date;
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          _getHeureButton(
                                            context,
                                            "A",
                                            (date) {
                                              if (dateTime != null) {
                                                dateTime = DateTime(
                                                    dateTime!.year,
                                                    dateTime!.month,
                                                    dateTime!.day,
                                                    date.hour,
                                                    date.minute);
                                              } else {
                                                dateTime = DateTime(
                                                    DateTime.now().year,
                                                    DateTime.now().month,
                                                    DateTime.now().day,
                                                    date.hour,
                                                    date.minute);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      _getChampWidget(
                                          'pour',
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: AppPadding.p8),
                                            child: TextFormField(
                                              controller: _nbrPersonne,
                                              keyboardType: TextInputType.phone,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none),
                                            ),
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: (() async {
                                              int nbrPers = 0;
                                              try {
                                                nbrPers = double.parse(
                                                        _nbrPersonne.text)
                                                    .toInt();
                                              } catch (_) {}
                                              if (dateTime != null &&
                                                  nbrPers > 0) {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) => Dialog(
                                                        insetPadding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        backgroundColor:
                                                            ColorManager.black
                                                                .withOpacity(
                                                                    AppOpacity
                                                                        .o05),
                                                        child:
                                                            loadingWidget()));
                                                await _viewModel
                                                    .postReservation(
                                                  dateTime!,
                                                  nbrPers,
                                                  snapShot.data!,
                                                );
                                                Navigator.pop(context);
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        const Dialog(
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
                                    ]),
                              const SizedBox(
                                height: 500,
                              )
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

  _getHeureButton(
      BuildContext context, String title, Function(TimeOfDay) onTimeChanged) {
    TimeOfDay? initialTime;
    return Expanded(
      child: GestureDetector(
        onTap: (() {
          showDialog(
              context: context,
              builder: (context) {
                return TimePickerDialog(
                  initialTime: initialTime ?? TimeOfDay.now(),
                  onEntryModeChanged: (time) {},
                );
              }).then((value) {
            onTimeChanged(value);
            initialTime = value;
          });
        }),
        child: Container(
          height: AppSize.s40,
          decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(AppSize.s25),
              border:
                  Border.all(color: ColorManager.grey, width: AppSize.s0_5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Icon(
                Icons.date_range,
                size: 17,
              )
            ],
          ),
        ),
      ),
    );
  }
}
