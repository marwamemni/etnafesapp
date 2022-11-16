// ignore_for_file: use_build_context_synchronously

import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/add_hebergment/viewmodel/add_hebergment_viewmodel.dart';
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
import 'package:open_location_picker/open_location_picker.dart';

import '../../../app/di.dart';

class AddHebergementView extends StatefulWidget {
  const AddHebergementView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddHebergementViewState createState() => _AddHebergementViewState();
}

class _AddHebergementViewState extends State<AddHebergementView> {
  final AddHebergmentViewModel _viewModel = instance<AddHebergmentViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _nbrVoyager = TextEditingController();
  final TextEditingController _nbrChambreIndiv = TextEditingController();
  final TextEditingController _nbrChambreDeux = TextEditingController();
  final TextEditingController _nbrChambreTrois = TextEditingController();
  final TextEditingController _nbrSuit = TextEditingController();
  final TextEditingController _prixChambreIndiv = TextEditingController();
  final TextEditingController _prixChambreDeux = TextEditingController();
  final TextEditingController _prixChambreTrois = TextEditingController();
  final TextEditingController _prixSuit = TextEditingController();
  String? _categorie;
  final TextEditingController _description = TextEditingController();
  String? _photoCoverture;
  DateTime? _dateDebut;
  DateTime? _dateFin;

  Paye? _paye;
  Ville? _ville;
  FormattedLocation? _position;

  _bind() {
    _viewModel.start(); // tell viewmodel, start ur job
    _viewModel.outputIsHebergmentPosted.listen((event) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(Routes.homeHebergerRoute);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<void>(
                        stream: _viewModel.outputDropDownValueChange,
                        builder: (context, snapshot) {
                          return _basicInputWidget();
                        }),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p20, top: AppPadding.p20),
                      child: Text(
                        'Photos',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    StreamBuilder<List<String>>(
                        stream: _viewModel.outputPhoto,
                        builder: (context, snapshot) {
                          return _getPhotosWidget(snapshot.data);
                        }),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p20,
                          top: AppPadding.p20,
                          bottom: AppPadding.p4),
                      child: Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: AppPadding.p20),
                      height: AppSize.s110,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: AppPadding.p20, right: AppPadding.p4),
                      decoration: BoxDecoration(
                          color: ColorManager.grey.withOpacity(AppOpacity.o05),
                          borderRadius: BorderRadius.circular(AppSize.s25)),
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
                    _textInput(
                      'Prix Chambre indiv',
                      _prixChambreIndiv,
                    ),
                    _textInput(
                      'Prix chambre double',
                      _prixChambreDeux,
                    ),
                    _textInput(
                      'Prix chambre triple',
                      _prixChambreTrois,
                    ),
                    _textInput(
                      'Prix Suite',
                      _prixSuit,
                    ),
                    SizedBox(
                      height: AppSize.s50 * (size.height / AppSize.xdHeight),
                    ),
                    _textInput('nombre de place disponibles', _nbrVoyager,
                        leftPadding: 0),
                    SizedBox(
                      height: AppSize.s50 * (size.height / AppSize.xdHeight),
                    ),
                    Text(
                      'nombre de chambres disponibles',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    _textInput(
                      'Individuelles',
                      _nbrChambreIndiv,
                    ),
                    _textInput(
                      'doubles',
                      _nbrChambreDeux,
                    ),
                    _textInput(
                      'Triples',
                      _nbrChambreTrois,
                    ),
                    _textInput(
                      'Suites',
                      _nbrSuit,
                    ),
                    const SizedBox(
                      height: AppSize.s15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: AppSize.s15,
                        ),
                        SizedBox(
                          height: AppSize.s60,
                          width: AppSize.s45,
                          child: OpenMapPicker(
                            removeIcon: null,
                            onChanged: (FormattedLocation? newValue) =>
                                _position = newValue,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: null,
                              prefixIcon: Container(
                                height: AppSize.s60,
                                width: AppSize.s45,
                                padding: const EdgeInsets.all(AppPadding.p8),
                                decoration: BoxDecoration(
                                    color: ColorManager.orangeclair,
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s15)),
                                child: SvgPicture.asset(
                                  ImageAssets.mapIcon,
                                  color: ColorManager.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width:
                              AppSize.s23_5 * (size.width / AppSize.xdweight),
                        ),
                        Text(
                          'Postion sur map',
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s50 * (size.height / AppSize.xdHeight),
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
                ),
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
                      .pushReplacementNamed(Routes.homeHebergerRoute);
                },
                icon: SvgPicture.asset(ImageAssets.backIcon)),
            IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () async {
                  if (_isValid()) {
                    int nbrVoyager = int.parse(_nbrVoyager.text);
                    int nbrChambreIndiv = int.parse(_nbrChambreIndiv.text);
                    int nbrChambreDeux = int.parse(_nbrChambreDeux.text);
                    int nbrChambreTrois = int.parse(_nbrChambreTrois.text);
                    int nbrSuit = int.parse(_nbrSuit.text);
                    int nbrChambreDisp = nbrChambreIndiv +
                        nbrChambreDeux +
                        nbrChambreTrois +
                        nbrSuit;
                    double prixChambreIndiv =
                        double.parse(_prixChambreIndiv.text);
                    double prixChambreDeux =
                        double.parse(_prixChambreDeux.text);
                    double prixChambreTrois =
                        double.parse(_prixChambreTrois.text);
                    double prixSuit = double.parse(_prixSuit.text);

                    showDialog(
                        context: context, builder: (_) => loadingWidget());
                    await _viewModel.postHebergment(
                        name: _name.text,
                        villeId: _ville!.id,
                        nbrVoyager: nbrVoyager,
                        nbrChambreDisp: nbrChambreDisp,
                        nbrChambreIndiv: nbrChambreIndiv,
                        nbrChambreDeux: nbrChambreDeux,
                        nbrChambreTrois: nbrChambreTrois,
                        nbrSuit: nbrSuit,
                        prixChambreIndiv: prixChambreIndiv,
                        prixChambreDeux: prixChambreDeux,
                        prixChambreTrois: prixChambreTrois,
                        prixSuit: prixSuit,
                        categorie: _categorie!,
                        description: _description.text,
                        photoCoverture: _photoCoverture!,
                        latitude: _position!.lat,
                        longitude: _position!.lon,
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
        Padding(
          padding:
              const EdgeInsets.only(left: AppPadding.p40, top: AppPadding.p8),
          child: Text(
            'Ajouter un hebergement',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: ColorManager.grey),
          ),
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
          Padding(
            padding: const EdgeInsets.all(AppPadding.p4),
            child: Text(
              'Nom',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              hintText: 'Foulan',
            ),
          ),
          getDropDownButton<Paye>('Paye', _viewModel.outputPays,
              (selectedPaye) async {
            if (selectedPaye != null) {
              showDialog(context: context, builder: (_) => loadingWidget());
              await _viewModel.setPaye(selectedPaye.id);
              _paye = selectedPaye;
              _ville = null;
              _viewModel.inputDropDownValueChange.add(null);
              Navigator.pop(context);
            }
          }, _paye, context),
          getDropDownButton<Ville>('Ville', _viewModel.outputvilles,
              (selectedVille) {
            if (selectedVille != null) {
              _ville = selectedVille;
              _viewModel.inputDropDownValueChange.add(null);
            }
          }, _ville, context),
          getDropDownButton<String>('Type', _viewModel.outputTypes,
              (selectedType) {
            if (selectedType != null) {
              _categorie = selectedType;
              _viewModel.inputDropDownValueChange.add(null);
            }
          }, _categorie, context),
        ],
      ),
    );
  }

  Widget _getPhotosWidget(
    List<String>? photos,
  ) {
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

  bool _isDouble(String str) => !(double.tryParse(str)?.isNegative ?? true);

  bool _isInt(String str) => !(int.tryParse(str)?.isNegative ?? true);

  bool _isValid() =>
      _isInt(_nbrVoyager.text) &&
      _isInt(_nbrChambreIndiv.text) &&
      _isInt(_nbrChambreDeux.text) &&
      _isInt(_nbrChambreTrois.text) &&
      _isInt(_nbrSuit.text) &&
      _isDouble(_prixChambreIndiv.text) &&
      _isDouble(_prixChambreDeux.text) &&
      _isDouble(_prixChambreTrois.text) &&
      _isDouble(_prixSuit.text) &&
      _categorie != null &&
      _photoCoverture != null &&
      _dateDebut != null &&
      _dateFin != null &&
      _position != null &&
      _ville != null;
}
