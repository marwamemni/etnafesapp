// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_divider_line.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/dateButton.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/loading_widget.dart';
import 'package:agence_voyage/presentation/edit_pack/viewmodel/edit_pack_viewmodel.dart';
import 'package:agence_voyage/presentation/resources/assets_manager.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/routes_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/di.dart';

class EditPackView extends StatefulWidget {
  const EditPackView({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  // ignore: library_private_types_in_public_api
  _EditPackViewState createState() => _EditPackViewState();
}

class _EditPackViewState extends State<EditPackView> {
  final EditPackViewModel _viewModel = instance<EditPackViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _nbrVoyager = TextEditingController();
  final TextEditingController _prix = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _activity = TextEditingController();
  String? _photoCoverture;
  DateTime? _dateDebut;
  DateTime? _dateFin;

  bool _isDataNotInitialized = true;

  _bind() async {
    await _viewModel.getPack(widget.id);
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
        child: StreamBuilder<Pack>(
            stream: _viewModel.outputPack,
            builder: (context, snapshot) {
              if (snapshot.hasData && _isDataNotInitialized) {
                _name.text = snapshot.data!.name;
                _nbrVoyager.text = snapshot.data!.nbrPlaceDisp.toString();
                _prix.text = snapshot.data!.prix.toString();
                _description.text = snapshot.data!.description;
                _photoCoverture = snapshot.data!.photoCoverture;
                _dateDebut = snapshot.data!.dateDebut;
                _dateFin = snapshot.data!.dateFin;
                _isDataNotInitialized = false;
              }
              return Column(
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
                              color:
                                  ColorManager.grey.withOpacity(AppOpacity.o05),
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppPadding.p20,
                              top: AppPadding.p20,
                              bottom: AppPadding.p4),
                          child: Text(
                            'Activites',
                            style: Theme.of(context).textTheme.titleMedium,
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
                                          hintText: 'ajout une activity'),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (_activity.text != '') {
                                          _viewModel
                                              .addActivity(_activity.text);
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
                                              index < activites.data!.length;
                                              index++)
                                            _textCustom(activites.data![index],
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
                        SizedBox(
                          height:
                              AppSize.s50 * (size.height / AppSize.xdHeight),
                        ),
                        _textInput('nombre de place disponibles', _nbrVoyager,
                            leftPadding: 0),
                        _textInput('prix package', _prix, leftPadding: 0),
                        SizedBox(
                          height:
                              AppSize.s50 * (size.height / AppSize.xdHeight),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p40),
                          child: Row(
                            children: [
                              getDateButton(context, 'De', (date) {
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
                        SizedBox(
                          height: size.height / 2,
                        ),
                      ],
                    )),
                  ),
                ],
              );
            }),
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
                    showDialog(
                        context: context, builder: (_) => loadingWidget());
                    await _viewModel.updatePack(
                        name: _name.text,
                        prix: prix,
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
        _getNameWidget(),
        divider(),
      ],
    );
  }

  Widget _getNameWidget() {
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
                    onLongPress: (() {
                      _viewModel.removePhoto(photo);
                    }),
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
      _dateFin != null;
}
