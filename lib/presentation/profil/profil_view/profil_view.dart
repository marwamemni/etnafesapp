// ignore_for_file: use_build_context_synchronously

import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_divider_line.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/drop_down_button.dart';
import 'package:agence_voyage/presentation/common/state_renderer/state_renderer.dart';
import 'package:agence_voyage/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:agence_voyage/presentation/profil/profil_viewmodel/profil_viewmodel.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/di.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfilViewState createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  final ProfilViewModel _viewModel = instance<ProfilViewModel>();

  final TextEditingController _firstNameEditingController =
      TextEditingController();
  final TextEditingController _lastNameEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _mobileNumberEditingController =
      TextEditingController(text: user.phone);

  final ImagePicker _imagePicker = instance<ImagePicker>();
  Paye? paye;
  Ville? ville;
  String? civilite = user.civilite;
  String photo = user.photo;
  _bind() {
    _viewModel.start();
    _viewModel.outputIsUserLogedOut.listen((event) {
      Navigator.pushReplacementNamed(context, Routes.splashRoute);
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
        backgroundColor: ColorManager.bleuclair,
        appBar: AppBar(
          title: Text(
            "Gérer Votre Compte",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          backgroundColor: ColorManager.bleuclair,
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
        body: StreamBuilder<bool>(
            stream: _viewModel.outputProfilUpdated,
            builder: (context, snapshot) {
              return _getContentWidget(size);
            }));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _getContentWidget(Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height - AppSize.s200,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Column(
                children: [
                  _getGeneralInfoWidget(),
                  divider(),
                  _getPersonnelInfoWidget(),
                  divider(),
                  _getSecuriteWidget(),
                  divider(),
                  _getPointsWidget(),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSize.s100, child: _getButtonsWidget()),
        ],
      ),
    );
  }

  Widget _getGeneralInfoWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Form(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => _showPicker(context),
              child: StreamBuilder<String>(
                  stream: _viewModel.outputProfilePicture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) photo = snapshot.data!;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s25),
                      child: Image.network(
                        photo,
                        fit: BoxFit.cover,
                        height: AppSize.s200,
                        width: AppSize.s200,
                      ),
                    );
                  }),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextFormField(
                        controller: _firstNameEditingController,
                        decoration: InputDecoration(
                            hintText: user.firstName,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.white),
                            ))),
                    TextFormField(
                        controller: _lastNameEditingController,
                        decoration: InputDecoration(
                            hintText: user.lastName,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.white),
                            ))),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Text(
                      user.userType,
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getPersonnelInfoWidget() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: StreamBuilder<bool>(
          stream: _viewModel.outputIsPersonnelInfoOpen,
          builder: (context, snapshot) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (snapshot.data ?? false) {
                      _viewModel.inputIsPersonnelInfoOpen.add(false);
                    } else {
                      _viewModel.inputIsPersonnelInfoOpen.add(true);
                      await Future.delayed(const Duration(milliseconds: 300));
                      _viewModel.inputCivility.add(null);
                      await _viewModel.getPays();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Change donnés personnels",
                        style: Theme.of(context).textTheme.titleSmall,
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
                        getDropDownButton<Paye>("Pays", _viewModel.outputPays,
                            (value) {
                          paye = value;
                          ville = null;
                          if (value != null) _viewModel.setPaye(value.id);
                          _viewModel.inputIsPersonnelInfoOpen.add(true);
                        }, paye, context),
                        getDropDownButton<Ville>(
                            "Ville", _viewModel.outputvilles, (value) {
                          ville = value;
                          _viewModel.inputIsPersonnelInfoOpen.add(true);
                        }, ville, context),
                        getDropDownButton<String>(
                            "Etat civil", _viewModel.outputcivilites, (value) {
                          civilite = value;
                          _viewModel.inputIsPersonnelInfoOpen.add(true);
                        }, civilite, context),
                      ],
                    ),
                  )
              ],
            );
          }),
    );
  }

  Widget _getSecuriteWidget() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: StreamBuilder<bool>(
          stream: _viewModel.outputIsSecuritelInfoOpen,
          builder: (context, snapshot) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (snapshot.data ?? false) {
                      _viewModel.inputIsSecuriteInfoOpen.add(false);
                    } else {
                      _viewModel.inputIsSecuriteInfoOpen.add(true);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sécurité",
                        style: Theme.of(context).textTheme.titleSmall,
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
                        _getChampWidget(
                            "Adress e-mail",
                            Padding(
                              padding: const EdgeInsets.all(AppPadding.p4),
                              child: Text(
                                user.email,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            )),
                        _getChampWidget(
                            "N° de télèphonne",
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: AppPadding.p8),
                              child: TextFormField(
                                controller: _mobileNumberEditingController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none),
                              ),
                            )),
                        _getChampWidget(
                            "Mot de passe",
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: AppPadding.p8),
                              child: TextFormField(
                                controller: _passwordEditingController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none),
                              ),
                            )),
                      ],
                    ),
                  )
              ],
            );
          }),
    );
  }

  Widget _getChampWidget(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: AppSize.s100,
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelSmall,
            ),
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

  Widget _getPointsWidget() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "N° des points:",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            width: AppSize.s45,
          ),
          Text(
            "${user.points} pts",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  Widget _getButtonsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: () {
              _viewModel.logout();
            },
            child: const Text("Se déconnecter")),
        IconButton(
            iconSize: 70,
            onPressed: () async {
              showPopup(
                  context, StateRendererType.popupLoadingState, "message");
              await _viewModel.updateProfil(
                  _firstNameEditingController.text,
                  _lastNameEditingController.text,
                  photo,
                  ville,
                  civilite,
                  _mobileNumberEditingController.text,
                  _passwordEditingController.text);
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(ImageAssets.checkIcon)),
      ],
    );
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
      _viewModel.setProfilePicture(image);
    }
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) _viewModel.setProfilePicture(image);
  }
}
