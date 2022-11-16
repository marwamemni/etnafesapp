import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_divider_line.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/dateButton.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/loading_widget.dart';
import 'package:agence_voyage/presentation/edit_hebergement/viewmodel/edit_hebergement_viewmodel.dart';
import 'package:agence_voyage/presentation/resources/assets_manager.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/routes_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_location_picker/open_location_picker.dart';

class EditHebergmentView extends StatefulWidget {
  const EditHebergmentView({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<EditHebergmentView> createState() => _EditHebergmentViewState();
}

class _EditHebergmentViewState extends State<EditHebergmentView> {
  final EditHebergmentViewModel _viewModel =
      instance<EditHebergmentViewModel>();
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
  final TextEditingController _description = TextEditingController();
  String? _photoCoverture;
  DateTime? _dateDebut;
  DateTime? _dateFin;

  double? _latitude;
  double? _longitude;

  bool _isDataNotInitialized = true;

  _bind() async {
    await _viewModel.getheberg(widget.id);
    _viewModel.outputIsHebergmentUpdated.listen((event) {
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
            onPressed: (() => Navigator.pushReplacementNamed(
                context, Routes.homeHebergerRoute)),
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
                      if (_isDataNotInitialized) {
                        _name.text = snapShot.data!.name;
                        _nbrVoyager.text = snapShot.data!.nbrVoyager.toString();
                        _nbrChambreIndiv.text =
                            snapShot.data!.nbrChambreIndiv.toString();
                        _nbrChambreDeux.text =
                            snapShot.data!.nbrChambreDeux.toString();
                        _nbrChambreTrois.text =
                            snapShot.data!.nbrChambreTrois.toString();
                        _nbrSuit.text = snapShot.data!.nbrSuit.toString();
                        _prixChambreIndiv.text =
                            snapShot.data!.prixChambreIndiv.toString();
                        _prixChambreDeux.text =
                            snapShot.data!.prixChambreDeux.toString();
                        _prixChambreTrois.text =
                            snapShot.data!.prixChambreTrois.toString();
                        _prixSuit.text = snapShot.data!.prixSuit.toString();
                        _description.text = snapShot.data!.description;
                        _photoCoverture = snapShot.data!.photoCoverture;
                        _dateDebut = snapShot.data!.dateDebut;
                        _dateFin = snapShot.data!.dateFin;
                        _latitude = snapShot.data!.latitude;
                        _longitude = snapShot.data!.longitude;
                        _isDataNotInitialized = false;
                      }
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
                                    Expanded(
                                      child: _changeText(_name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          textInputType: TextInputType.name),
                                    ),
                                    SizedBox(
                                      height: AppSize.s60,
                                      width: AppSize.s45,
                                      child: OpenMapPicker(
                                        removeIcon: null,
                                        initialValue:
                                            FormattedLocation.fromLatLng(
                                                lat: _latitude!,
                                                lon: _longitude!),
                                        onChanged:
                                            (FormattedLocation? newValue) {
                                          if (newValue != null) {
                                            _latitude = newValue.lat;
                                            _longitude = newValue.lon;
                                          }
                                        },
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
                                            padding: const EdgeInsets.all(
                                                AppPadding.p8),
                                            decoration: BoxDecoration(
                                                color: ColorManager.orangeclair,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s15)),
                                            child: SvgPicture.asset(
                                              ImageAssets.mapIcon,
                                              color: ColorManager.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
                                child: SizedBox(
                                  width: 200,
                                  child: _changeText(_description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(color: ColorManager.black),
                                      textInputType: TextInputType.multiline),
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
                              StreamBuilder<List<String>>(
                                  stream: _viewModel.outputPhoto,
                                  builder: (context, photos) {
                                    if (photos.hasData) {
                                      return _getPhotosWidget(photos.data!);
                                    } else {
                                      return loadingWidget();
                                    }
                                  }),
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
                                height: AppSize.s50 *
                                    (size.height / AppSize.xdHeight),
                              ),
                              _textInput(
                                  'nombre de place disponibles', _nbrVoyager,
                                  leftPadding: 0),
                              SizedBox(
                                height: AppSize.s50 *
                                    (size.height / AppSize.xdHeight),
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
                              Padding(
                                padding: const EdgeInsets.all(AppPadding.p20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    getDateButton(context, "DE", (date) {
                                      _dateDebut = date;
                                    }, initialDate: _dateDebut),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    getDateButton(context, "A", (date) {
                                      _dateFin = date;
                                    }, initialDate: _dateFin),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: (() async {
                                      if (_isValid()) {
                                        int nbrChambreIndiv =
                                            int.parse(_nbrChambreIndiv.text);
                                        int nbrChambreDeux =
                                            int.parse(_nbrChambreDeux.text);
                                        int nbrChambreTrois =
                                            int.parse(_nbrChambreTrois.text);
                                        int nbrSuit = int.parse(_nbrSuit.text);
                                        int nbrChambreDisp = nbrChambreIndiv +
                                            nbrChambreDeux +
                                            nbrChambreTrois +
                                            nbrSuit;
                                        showDialog(
                                            context: context,
                                            builder: (_) => loadingWidget());
                                        await _viewModel.updateHebergment(
                                            name: _name.text,
                                            nbrVoyager:
                                                int.parse(_nbrVoyager.text),
                                            nbrChambreDisp: nbrChambreDisp,
                                            nbrChambreIndiv: nbrChambreIndiv,
                                            nbrChambreDeux: nbrChambreDeux,
                                            nbrChambreTrois: nbrChambreTrois,
                                            nbrSuit: nbrSuit,
                                            prixChambreIndiv: double.parse(
                                                _prixChambreIndiv.text),
                                            prixChambreDeux: double.parse(
                                                _prixChambreDeux.text),
                                            prixChambreTrois: double.parse(
                                                _prixChambreTrois.text),
                                            prixSuit:
                                                double.parse(_prixSuit.text),
                                            description: _description.text,
                                            photoCoverture: _photoCoverture!,
                                            latitude: _latitude!,
                                            longitude: _longitude!,
                                            dateDebut: _dateDebut!,
                                            dateFin: _dateFin!);
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) => const Dialog(
                                                  child:
                                                      Text("Check your inputs"),
                                                ));
                                      }
                                    }),
                                    icon: SvgPicture.asset(
                                      ImageAssets.checkIcon,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height / 2,
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
                              left: AppSize.s15,
                              top: AppSize.s4,
                              child: Image.asset(photo == _photoCoverture
                                  ? ImageAssets.selectedIcon
                                  : ImageAssets.unselectedIcon)),
                          Positioned(
                            bottom: AppSize.s4,
                            right: AppSize.s8,
                            child: IconButton(
                                onPressed: () => _viewModel.deletePhoto(photo),
                                icon: CircleAvatar(
                                    child: Icon(
                                  Icons.delete,
                                  color: ColorManager.white,
                                  size: AppSize.s16,
                                ))),
                          )
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

  Widget _changeText(TextEditingController controller,
      {TextStyle? style, TextInputType textInputType = TextInputType.number}) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      style: style,
      keyboardType: textInputType,
      decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none),
    );
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
      _photoCoverture != null &&
      _dateDebut != null &&
      _dateFin != null &&
      _latitude != null &&
      _longitude != null;
}
