// ignore_for_file: use_build_context_synchronously

import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/loading_widget.dart';
import 'package:agence_voyage/presentation/edit%20restaurant/viewmodel/edit_restaurant_viewmodel.dart';
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

class EditRestaurantView extends StatefulWidget {
  const EditRestaurantView({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  // ignore: library_private_types_in_public_api
  _EditRestaurantViewState createState() => _EditRestaurantViewState();
}

class _EditRestaurantViewState extends State<EditRestaurantView> {
  final EditRestaurantViewModel _viewModel =
      instance<EditRestaurantViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  String? _photoCoverture;

  FormattedLocation? _position;

  bool _isDataNotInitialased = true;
  _bind() async {
    await _viewModel.getRestaurant(widget.id);
    _viewModel.start(); // tell viewmodel, start ur job
    _viewModel.outputIsHebergmentPosted.listen((event) {
      print("8888888888888888888888888888888888888888888888888888");
      print(event);
      print("8888888888888888888888888888888888888888888888888888");
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushReplacementNamed(Routes.homeProprieterRestauRoute);
    });
  }

  @override
  void initState() {
    print("8888888888888888888888888888888888888888888888888888");
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
        child: StreamBuilder<Restaurant>(
            stream: _viewModel.outputRestaurant,
            builder: (context, restaurant) {
              print("1111111111111111111111111111111111111111111111111");
              if (restaurant.hasData && _isDataNotInitialased) {
                print("22222222222222222222222222222222222222222222222222");
                _name.text = restaurant.data!.name;
                _description.text = restaurant.data!.description;
                _photoCoverture = restaurant.data!.photoCoverture;
                _position = FormattedLocation.fromLatLng(
                    lat: restaurant.data!.latitude,
                    lon: restaurant.data!.longitude);

                _isDataNotInitialased = false;
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
                          StreamBuilder<void>(
                              stream: _viewModel.outputDropDownValueChange,
                              builder: (context, snapshot) {
                                return _basicInputWidget(size);
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
                          const SizedBox(
                            height: AppSize.s15,
                          ),
                        ],
                      ),
                    ),
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
                      .pushReplacementNamed(Routes.homeProprieterRestauRoute);
                },
                icon: SvgPicture.asset(ImageAssets.backIcon)),
            IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () async {
                  if (_isValid()) {
                    showDialog(
                        context: context, builder: (_) => loadingWidget());
                    await _viewModel.updateRestaurant(
                      name: _name.text,
                      description: _description.text,
                      photoCoverture: _photoCoverture!,
                      latitude: _position!.lat,
                      longitude: _position!.lon,
                    );
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
          padding: const EdgeInsets.only(
              left: AppPadding.p40, top: AppPadding.p8, bottom: AppPadding.p20),
          child: Text(
            'Modifier ${_name.text}',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: ColorManager.grey),
          ),
        ),
      ],
    );
  }

  Widget _basicInputWidget(Size size) {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: TextField(
              controller: _name,
              decoration: const InputDecoration(
                hintText: 'PIZZA HOT',
              ),
            ),
          ),
          const SizedBox(
            height: AppSize.s30,
          ),
          Container(
            height: AppSize.s110,
            padding: const EdgeInsets.only(left: AppPadding.p20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: AppSize.s15,
                ),
                SizedBox(
                  height: AppSize.s60,
                  width: AppSize.s45,
                  child: OpenMapPicker(
                    initialValue: _position,
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
                            borderRadius: BorderRadius.circular(AppSize.s15)),
                        child: SvgPicture.asset(
                          ImageAssets.mapIcon,
                          color: ColorManager.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: AppSize.s23_5 * (size.width / AppSize.xdweight),
                ),
                Text(
                  'Postion sur map',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ),
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
                    onLongPress: () {
                      _viewModel.removePhoto(photo);
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

  bool _isValid() => _photoCoverture != null && _position != null;
}
