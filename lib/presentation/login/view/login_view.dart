import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_background.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_divider_line.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_row_buttons.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_text_input_with_validator.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/loading_widget.dart';
import 'package:agence_voyage/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:agence_voyage/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../../../app/di.dart';
import '../../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  bool isLoading = false;
  _bind() {
    _viewModel.start(); // tell viewmodel, start ur job
    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });
    _userPasswordController.addListener(() {
      _viewModel.setPassword(_userPasswordController.text);
    });
    _viewModel.outIsUserLoggedIn.listen((event) {
      if (event) {
        if (user.userType == UserType.voyageur.name) {
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        } else if (user.userType == UserType.adminAgence.name) {
          Navigator.of(context).pushReplacementNamed(Routes.homeAdminRoute);
        } else if (user.userType == UserType.prorietereResto.name) {
          Navigator.of(context)
              .pushReplacementNamed(Routes.homeProprieterRestauRoute);
        } else if (user.userType == UserType.prorietereHeberg.name) {
          Navigator.of(context).pushReplacementNamed(Routes.homeHebergerRoute);
        }
      }
    });
    _viewModel.outputState.listen((event) {
      if (event != null) {
        event.getScreenWidget(context, () {});
      }
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
                    "S'identifier",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                divider(),
                Container(
                  height: size.height * 0.56 - 110,
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textInputWithValidation(
                          context,
                          "E-mail",
                          "marwa@gmail.com",
                          _emailController,
                          _viewModel.outIsEmailValid,
                          false),
                      textInputWithValidation(
                          context,
                          "Mot de passe",
                          "*********",
                          _userPasswordController,
                          _viewModel.outIsPasswordValid,
                          true),
                      TextButton(
                          onPressed: () async {
                            LoadingState().getScreenWidget(context, () {});
                            await Future.delayed(
                                const Duration(milliseconds: 300));
                            await _viewModel.forgotPassword();
                          },
                          child: Text(
                            "Mot de passe oublié?",
                            style: Theme.of(context).textTheme.titleSmall,
                          ))
                    ],
                  ),
                ),
                getDownRowButtons(_viewModel.outAreAllInputsValid, () async {
                  showDialog(
                      context: context,
                      builder: (_) => Dialog(
                          insetPadding: const EdgeInsets.all(0),
                          backgroundColor:
                              ColorManager.black.withOpacity(AppOpacity.o05),
                          child: loadingWidget()));
                  await _viewModel.login();
                }, context)
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _emailController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }
}
