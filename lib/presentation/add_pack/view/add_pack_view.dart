// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/add_pack/viewmodel/add_pack_viewmodel.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_divider_line.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/dateButton.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/drop_down_button.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/loading_widget.dart';
import 'package:agence_voyage/presentation/resources/assets_manager.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/routes_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../app/di.dart';

class AddPackView extends StatefulWidget {
  const AddPackView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddPackViewState createState() => _AddPackViewState();
}

class _AddPackViewState extends State<AddPackView> {
  final AddPackViewModel _viewModel = instance<AddPackViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _nbrVoyager = TextEditingController();
  final TextEditingController _prix = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _activity = TextEditingController();
  String? _photoCoverture;
  DateTime? _dateDebut;
  DateTime? _dateFin;

  List<Ville>? _villes;
  List<Hebergment> _hebergments = [];
  List<Restaurant> _restaurants = [];

  Paye? _paye;

  _bind() {
    _viewModel.start(); // tell viewmodel, start ur job
    _viewModel.outputIsHebergmentPosted.listen((event) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(Routes.homeAdminRoute);
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top,
            ),
            _appBar(),
            Expanded(
              child: SingleChildScrollView(
                child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsActiviteOpen,
                    builder: (context, isActiviteOpen) {
                      return (isActiviteOpen.data ?? false)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: AppPadding.p20,
                                      top: AppPadding.p20,
                                      bottom: AppPadding.p4),
                                  child: Text(
                                    'Description',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: AppPadding.p20),
                                  height: AppSize.s110,
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                      left: AppPadding.p20,
                                      right: AppPadding.p4),
                                  decoration: BoxDecoration(
                                      color: ColorManager.grey
                                          .withOpacity(AppOpacity.o05),
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s25)),
                                  child: TextField(
                                    controller: _description,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    style: TextStyle(color: ColorManager.black),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: "hello *******"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: AppPadding.p20,
                                      top: AppPadding.p20,
                                      bottom: AppPadding.p4),
                                  child: Text(
                                    'Activites',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: AppPadding.p20,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _activity,
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      'ajout une activity'),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                if (_activity.text != '') {
                                                  _viewModel.addActivity(
                                                      _activity.text);
                                                  _activity.text = '';
                                                }
                                              },
                                              icon: SvgPicture.asset(
                                                  ImageAssets.checkIcon))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      StreamBuilder<List<String>>(
                                          stream: _viewModel.outputActivites,
                                          builder: (context, activites) {
                                            if (activites.hasData) {
                                              return Column(
                                                children: [
                                                  for (int index = 0;
                                                      index <
                                                          activites
                                                              .data!.length;
                                                      index++)
                                                    _textCustom(
                                                        activites.data![index],
                                                        'act ${index + 1}'),
                                                ],
                                              );
                                            } else {
                                              return const SizedBox();
                                            }
                                          }),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: AppPadding.p20,
                                      top: AppPadding.p20),
                                  child: Text(
                                    'Photos',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                StreamBuilder<List<String>>(
                                    stream: _viewModel.outputPhoto,
                                    builder: (context, snapshot) {
                                      return _getPhotosWidget(snapshot.data);
                                    }),
                                SizedBox(
                                  height: AppSize.s50 *
                                      (size.height / AppSize.xdHeight),
                                ),
                                _textInput(
                                    'nombre de place disponibles', _nbrVoyager,
                                    leftPadding: 0),
                                _textInput('prix package', _prix,
                                    leftPadding: 0),
                                SizedBox(
                                  height: AppSize.s50 *
                                      (size.height / AppSize.xdHeight),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppPadding.p40),
                                  child: Row(
                                    children: [
                                      getDateButton(
                                        context,
                                        'De',
                                        (date) {
                                          _dateDebut = date;
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      getDateButton(
                                        context,
                                        "A",
                                        (date) {
                                          _dateFin = date;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height / 2,
                                ),
                              ],
                            )
                          : Column(children: [
                              const SizedBox(
                                height: 20,
                              ),
                              StreamBuilder<void>(
                                  stream: _viewModel.outputHebOrResChanged,
                                  builder: (context, snapshot) {
                                    return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Hebergments",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Builder(builder: (context) {
                                            List<Widget> items = _hebergments
                                                .map((heb) => GestureDetector(
                                                    onLongPress: () {
                                                      _hebergments.remove(heb);
                                                      _viewModel
                                                          .inputHebOrResChanged
                                                          .add(null);
                                                    },
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              Routes
                                                                  .hebergmentDetailsRoute,
                                                              arguments:
                                                                  ElementId(
                                                                      heb.id));
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: (size.width -
                                                                      AppSize
                                                                          .s80) *
                                                                  0.65625 -
                                                              20,
                                                          width: size.width -
                                                              AppSize.s80,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    ColorManager
                                                                        .white,
                                                                width: 1),
                                                          ),
                                                          child: Image.network(
                                                            heb.photoCoverture,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Text(
                                                          heb.name,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                        ),
                                                      ],
                                                    )))
                                                .cast<Widget>()
                                                .toList();
                                            items.add(Column(
                                              children: [
                                                SizedBox(
                                                  height: (size.width -
                                                              AppSize.s80) *
                                                          0.65625 -
                                                      20,
                                                  width:
                                                      size.width - AppSize.s80,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      (await Navigator.of(
                                                              context)
                                                          .pushNamed(Routes
                                                              .hebergmentVoyageurRoute)
                                                          .then((value) {
                                                        Hebergment hebergment =
                                                            value as Hebergment;
                                                        if ((_hebergments.indexWhere(
                                                                (element) =>
                                                                    element
                                                                        .id ==
                                                                    hebergment
                                                                        .id)) ==
                                                            -1) {
                                                          _hebergments
                                                              .add(hebergment);

                                                          _viewModel
                                                              .inputHebOrResChanged
                                                              .add(null);
                                                        }
                                                      }));
                                                    },
                                                    child: Center(
                                                        child: SvgPicture.asset(
                                                            ImageAssets
                                                                .addIcon)),
                                                  ),
                                                ),
                                              ],
                                            ));
                                            return CarouselSlider(
                                                items: items,
                                                options: CarouselOptions(
                                                    height: (size.width -
                                                                AppSize.s80) *
                                                            0.65625 +
                                                        50,
                                                    autoPlay: true,
                                                    enableInfiniteScroll: false,
                                                    enlargeCenterPage: true));
                                          }),
                                          Text(
                                            "Restaurants",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Builder(builder: (context) {
                                            List<Widget> items = _restaurants
                                                .map((res) => GestureDetector(
                                                    onLongPress: () {
                                                      _restaurants.remove(res);
                                                      _viewModel
                                                          .inputHebOrResChanged
                                                          .add(null);
                                                    },
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              Routes
                                                                  .restaurantsDetailsRoute,
                                                              arguments:
                                                                  ElementId(
                                                                      res.id));
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: (size.width -
                                                                      AppSize
                                                                          .s80) *
                                                                  0.65625 -
                                                              20,
                                                          width: size.width -
                                                              AppSize.s80,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    ColorManager
                                                                        .white,
                                                                width: 1),
                                                          ),
                                                          child: Image.network(
                                                            res.photoCoverture,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Text(
                                                          res.name,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                        ),
                                                      ],
                                                    )))
                                                .cast<Widget>()
                                                .toList();
                                            items.add(Column(
                                              children: [
                                                SizedBox(
                                                  height: (size.width -
                                                              AppSize.s80) *
                                                          0.65625 -
                                                      20,
                                                  width:
                                                      size.width - AppSize.s80,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      (await Navigator.of(
                                                              context)
                                                          .pushNamed(Routes
                                                              .restaurantsVoyageurRoute)
                                                          .then((value) {
                                                        Restaurant restaurant =
                                                            value as Restaurant;
                                                        if ((_restaurants.indexWhere(
                                                                (element) =>
                                                                    element
                                                                        .id ==
                                                                    restaurant
                                                                        .id)) ==
                                                            -1) {
                                                          _restaurants
                                                              .add(restaurant);

                                                          _viewModel
                                                              .inputHebOrResChanged
                                                              .add(null);
                                                        }
                                                      }));
                                                    },
                                                    child: Center(
                                                        child: SvgPicture.asset(
                                                            ImageAssets
                                                                .addIcon)),
                                                  ),
                                                ),
                                              ],
                                            ));
                                            return CarouselSlider(
                                                items: items,
                                                options: CarouselOptions(
                                                    height: (size.width -
                                                                AppSize.s80) *
                                                            0.65625 +
                                                        50,
                                                    autoPlay: true,
                                                    enableInfiniteScroll: false,
                                                    enlargeCenterPage: true));
                                          })
                                        ]);
                                  })
                            ]);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.homeAdminRoute);
                },
                icon: SvgPicture.asset(ImageAssets.backIcon)),
            IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () async {
                  if (_isValid()) {
                    int nbrVoyager = int.parse(_nbrVoyager.text);
                    double prix = double.parse(_prix.text);
                    List<String> villeId = _villes!.map(((e) => e.id)).toList();
                    List<String> hebergments =
                        _hebergments.map(((e) => e.id)).toList();
                    List<String> restaurants =
                        _restaurants.map(((e) => e.id)).toList();
                    showDialog(
                        context: context, builder: (_) => loadingWidget());
                    await _viewModel.postPack(
                        name: _name.text,
                        villeId: villeId,
                        hebergments: hebergments,
                        prix: prix,
                        restaurants: restaurants,
                        nbrVoyager: nbrVoyager,
                        description: _description.text,
                        photoCoverture: _photoCoverture!,
                        dateDebut: _dateDebut!,
                        dateFin: _dateFin!);
                  } else {
                    showDialog(
                        context: context,
                        builder: (_) => const Dialog(
                              child: Text('Check Your inputs'),
                            ));
                  }
                },
                icon: SvgPicture.asset(ImageAssets.checkIcon)),
          ],
        ),
        StreamBuilder<void>(
            stream: _viewModel.outputDropDownValueChange,
            builder: (context, snapshot) {
              return _basicInputWidget();
            }),
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
                  onTap: () async {
                    _viewModel.inputIsActiviteOpen.add(true);
                    await Future.delayed(const Duration(milliseconds: 300));
                    _viewModel.inputActivites.add(List<String>.empty());
                    _viewModel.inputPhotos.add('');
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

  Widget _basicInputWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _name,
            style: Theme.of(context).textTheme.headlineMedium,
            decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Nom',
              hintStyle: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Container(
            child: getDropDownButton<Paye>('Paye', _viewModel.outputPays,
                (selectedPaye) async {
              if (selectedPaye != null) {
                showDialog(context: context, builder: (_) => loadingWidget());
                await _viewModel.setPaye(selectedPaye.id);
                _paye = selectedPaye;
                _viewModel.inputDropDownValueChange.add(null);
                Navigator.pop(context);
              }
            }, _paye, context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
            child: Row(
              children: [
                Text(
                  "Ville",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  width: AppSize.s25,
                ),
                Expanded(
                  child: Flex(direction: Axis.vertical, children: [
                    Container(
                      height: AppSize.s27,
                      decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(AppSize.s10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: AppPadding.p20),
                        child: StreamBuilder<List<Ville>>(
                            stream: _viewModel.outputvilles,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        padding: const EdgeInsets.only(
                                            left: AppPadding.p20),
                                        iconSize: AppSize.s30,
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return MultiSelectDialog(
                                                items: snapshot.data!
                                                    .map((e) => MultiSelectItem(
                                                        e, e.name))
                                                    .toList(),
                                                initialValue: _villes ?? [],
                                                onConfirm: (values) {
                                                  _villes = values
                                                      .map((e) => e)
                                                      .cast<Ville>()
                                                      .toList();
                                                },
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.arrow_drop_down))
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getPhotosWidget(List<String>? photos) {
    double height = (MediaQuery.of(context).size.width - 40) * 9 / 16;
    if (photos != null) {
      photos.remove('');
      photos.add('');
    } else {
      photos = [''];
    }
    return CarouselSlider(
        items: photos
            .map((photo) => photo != ''
                ? GestureDetector(
                    onTap: () {
                      _photoCoverture = photo;
                      _viewModel.inputPhotos.add('');
                    },
                    child: SizedBox(
                      height: height,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: height,
                            width: double.infinity,
                            child: Card(
                              elevation: AppSize.s1_5,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s12),
                                  side: BorderSide(
                                      color: ColorManager.grey,
                                      width: AppSize.s0_5)),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s12),
                                child: Image.network(
                                  photo,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              left: 15,
                              top: 5,
                              child: Image.asset(photo == _photoCoverture
                                  ? ImageAssets.selectedIcon
                                  : ImageAssets.unselectedIcon)),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      await _showPicker(context);
                    },
                    child: SizedBox(
                      height: height,
                      child: Card(
                        elevation: AppSize.s1_5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            side: BorderSide(
                                color: ColorManager.grey, width: AppSize.s0_5)),
                        child: Center(
                          child: SvgPicture.asset(ImageAssets.addIcon,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ))
            .toList(),
        options: CarouselOptions(
          autoPlay: true,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
        ));
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: const Text('photo gallery'),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('photo camera'),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _viewModel.addPhoto(image);
    }
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) _viewModel.addPhoto(image);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  _textInput(String title, TextEditingController controller,
      {double leftPadding = AppPadding.p20}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, top: AppPadding.p12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(
            width: AppSize.s10,
          ),
          Container(
              width: AppSize.s100,
              height: AppSize.s27,
              decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s10),
                  border: Border.all(color: ColorManager.grey)),
              child: Padding(
                padding: const EdgeInsets.only(left: AppPadding.p8),
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none),
                ),
              )),
        ],
      ),
    );
  }

  Widget _textCustom(String body, String title) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$title: ',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontSize: 13.5),
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
          IconButton(
              onPressed: () {
                _viewModel.removeActivity(body);
              },
              icon: const Icon(Icons.remove))
        ],
      ),
    );
  }

  bool _isDouble(String str) => !(double.tryParse(str)?.isNegative ?? true);

  bool _isInt(String str) => !(int.tryParse(str)?.isNegative ?? true);

  bool _isValid() =>
      _isInt(_nbrVoyager.text) &&
      _isDouble(_prix.text) &&
      _photoCoverture != null &&
      _dateDebut != null &&
      _dateFin != null &&
      _villes != null &&
      _hebergments != [] &&
      _restaurants != [] &&
      _villes != null &&
      _villes != [];
}
