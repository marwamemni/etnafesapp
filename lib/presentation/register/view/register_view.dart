import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_background.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_divider_line.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_row_buttons.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_text_input_with_validator.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/loading_widget.dart';
import 'package:agence_voyage/presentation/register/view_model/register_viewmodel.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/routes_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/di.dart';
import '../../resources/assets_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameEditingController =
      TextEditingController();
  final TextEditingController _lastNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _mobileNumberEditingController =
      TextEditingController();
  Paye? paye;
  Ville? ville;
  String? civilite;

  _bind() {
    _viewModel.start();
    _firstNameEditingController.addListener(() {
      _viewModel.setFirstName(_firstNameEditingController.text);
    });
    _lastNameEditingController.addListener(() {
      _viewModel.setLastName(_lastNameEditingController.text);
    });
    _emailEditingController.addListener(() {
      _viewModel.setEmail(_emailEditingController.text);
    });

    _passwordEditingController.addListener(() {
      _viewModel.setPassword(_passwordEditingController.text);
    });

    _mobileNumberEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberEditingController.text);
    });

    _viewModel.outIsUserLoggedIn.listen((event) {
      if (event) {
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      }
    });
  }

  bool isLoading = false;
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
        backgroundColor: ColorManager.splashBackgroundColor,
        body: _getContentWidget(size));
  }

  Widget _getContentWidget(Size size) {
    return Stack(
      children: [
        getBackgroundWidget(size, null),
        Center(
          child: Container(
            height: size.height * 0.56,
            width: size.width,
            margin: const EdgeInsets.symmetric(horizontal: AppMargin.m30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s60),
              color: ColorManager.white.withOpacity(AppOpacity.o05),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "S'inscrire",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                divider(),
                Form(
                  key: _formKey,
                  child: SizedBox(
                    height: size.height * 0.56 - 110,
                    child: StreamBuilder<void>(
                        stream: _viewModel.outputDropDownValueChange,
                        builder: (context, snapshot) {
                          return ListView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p20),
                            children: [
                              _textInput(
                                  "Nom",
                                  "Marwa",
                                  _firstNameEditingController,
                                  TextInputType.name),
                              _textInput(
                                  "Prènom",
                                  "Memni",
                                  _lastNameEditingController,
                                  TextInputType.name),
                              textInputWithValidation(
                                  context,
                                  "E-mail",
                                  "marwa@gmail.com",
                                  _emailEditingController,
                                  _viewModel.outputIsEmailValid,
                                  false),
                              textInputWithValidation(
                                  context,
                                  "Mot de passe",
                                  "*********",
                                  _passwordEditingController,
                                  _viewModel.outputIsPasswordValid,
                                  true),
                              _getDropDownButton<Paye>(
                                  "Pays", _viewModel.outputPays, (value) {
                                paye = value;
                                ville = null;
                                if (value != null) _viewModel.setPaye(value.id);
                                _viewModel.inputDropDownValueChange.add(null);
                              }, paye),
                              _getDropDownButton<Ville>(
                                  "Ville", _viewModel.outputvilles, (value) {
                                ville = value;
                                if (value != null) {
                                  _viewModel.setVille(value.id);
                                }
                                _viewModel.inputDropDownValueChange.add(null);
                              }, ville),
                              _getDropDownButton<String>(
                                  "Etat civil", _viewModel.outputcivilites,
                                  (value) {
                                civilite = value;
                                if (value != null) {
                                  _viewModel.setCivilite(value);
                                }
                                _viewModel.inputDropDownValueChange.add(null);
                              }, civilite),
                              _textInput(
                                  "Numéo de télèphonne",
                                  "22222222",
                                  _mobileNumberEditingController,
                                  TextInputType.phone),
                              _addPhoto()
                            ],
                          );
                        }),
                  ),
                ),
                divider(),
                getDownRowButtons(_viewModel.outputAreAllInputsValid, () async {
                  showDialog(
                      context: context,
                      builder: (_) => Dialog(
                          insetPadding: const EdgeInsets.all(0),
                          backgroundColor:
                              ColorManager.black.withOpacity(AppOpacity.o05),
                          child: loadingWidget()));
                  await _viewModel.register();
                  // Navigator.pop(
                  //     context);
                }, context)
              ],
            ),
          ),
        )
      ],
    );
  }

  Padding _addPhoto() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p8,
        vertical: AppPadding.p20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: AppSize.s100,
            height: AppSize.s50,
            child: Text(
              "Une photo de profile",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(
            width: AppSize.s100,
            height: AppSize.s80,
            child: IconButton(
              onPressed: () {
                _showPicker(context);
              },
              icon: StreamBuilder<String>(
                  stream: _viewModel.outputProfilePicture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image.network(
                        snapshot.data!,
                      );
                    } else {
                      return SvgPicture.asset(
                        ImageAssets.addImage,
                        fit: BoxFit.contain,
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget _getDropDownButton<Obj>(String title, Stream<List<Obj>>? stream,
      void Function(Obj?)? onChanged, Obj? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Row(
        children: [
          Text(
            title,
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
                  child: StreamBuilder<List<Obj>>(
                      stream: stream,
                      builder: (context, snapshot) {
                        return DropdownButton<Obj>(
                          iconEnabledColor: ColorManager.grey,
                          key: Key(Obj.runtimeType.toString()),
                          style: Theme.of(context).textTheme.titleSmall,
                          underline: const SizedBox(),
                          iconSize: AppSize.s30,
                          disabledHint: const SizedBox(),
                          isExpanded: true,
                          hint: Container(
                            color: ColorManager.white,
                          ),
                          value:
                              value, // this place should not have a controller but a variable
                          onChanged: onChanged,
                          items: snapshot.hasData
                              ? snapshot.data!
                                  .map<DropdownMenuItem<Obj>>((Obj val) =>
                                      DropdownMenuItem<Obj>(
                                          value:
                                              val, // add this property an pass the _value to it
                                          child: Text(
                                            val.toString(),
                                          )))
                                  .toList()
                              : null,
                        );
                      }),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _textInput(String title, String hint, TextEditingController controller,
      TextInputType? keyboardType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration.collapsed(hintText: hint))
        ],
      ),
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
    if (image != null) _viewModel.setProfilePicture(image);
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) _viewModel.setProfilePicture(image);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
