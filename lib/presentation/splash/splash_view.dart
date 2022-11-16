import 'dart:async';

import 'package:agence_voyage/app/app_prefs.dart';
import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/getUser_usecase.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/authentication_background.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  final StreamController _isUserLogedInStreamController =
      StreamController<bool>();

  @override
  void initState() {
    super.initState();
    _isUserLogedInStreamController.stream.listen((event) {
      if (event == true) {
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorManager.splashBackgroundColor,
      body: Stack(
        children: [
          getBackgroundWidget(
              size,
              Expanded(
                child: _getContentWidget(),
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _isUserLogedInStreamController.close();
    super.dispose();
  }

  Widget _getContentWidget() {
    return FutureBuilder<void>(
        future: _initApplication(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _getButtonsWidget();
          }
        });
  }

  Widget _getButtonsWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _getButton(Routes.mainRoute, "Invité"),
        _getButton(Routes.registerRoute, "S'inscrire"),
        _getButton(Routes.loginRoute, "S'identifier"),
      ],
    );
  }

  Widget _getButton(String route, String text) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(route);
      },
      child: Text(text),
    );
  }

  Future<void> _initApplication() async {
    if (isAppNotInitialized) {
      await initAppModule();
    }
    final AppPreferences appPreferences = instance<AppPreferences>();
    String? userId = await appPreferences.isUserLoggedIn();
    if (userId != null) {
      final GetUserUseCase getUserUseCase = instance<GetUserUseCase>();
      (await getUserUseCase.execute(userId)).fold((l) {}, (r) {
        initUser(r);
        _isUserLogedInStreamController.add(true);
      });
    }
  }
}
