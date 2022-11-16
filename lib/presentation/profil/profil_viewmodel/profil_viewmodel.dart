import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/logout_usecase.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/update_profil_usecase.dart';

import 'package:agence_voyage/presentation/register/view_model/register_viewmodel.dart';

import '../../../app/app_prefs.dart';

class ProfilViewModel extends RegisterViewModel with ProfilInput, ProfilOutput {
  StreamController isPersonnelInfoOpenStreamController =
      StreamController<bool>.broadcast();
  StreamController isSecuriteInfoOpenStreamController =
      StreamController<bool>.broadcast();
  StreamController isUserLogedOutStreamController =
      StreamController<bool>.broadcast();
  StreamController isProfilUpdatedStreamController =
      StreamController<bool>.broadcast();
  final LogoutUseCase _logoutUseCase = instance<LogoutUseCase>();
  final UpdateProfilUseCase _updateProfilUseCase =
      instance<UpdateProfilUseCase>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  ProfilViewModel(super.registerUseCase);

  @override
  void dispose() {
    isPersonnelInfoOpenStreamController.close();
    isSecuriteInfoOpenStreamController.close();
    isProfilUpdatedStreamController.close();
    isUserLogedOutStreamController.close();
    super.dispose();
  }

  // inputs

  @override
  Sink get inputIsPersonnelInfoOpen => isPersonnelInfoOpenStreamController.sink;

  @override
  Sink get inputIsUserLogedOut => isUserLogedOutStreamController.sink;

  @override
  Sink get inputProfilUpdated => isProfilUpdatedStreamController.sink;

  @override
  Sink get inputIsSecuriteInfoOpen => isSecuriteInfoOpenStreamController.sink;

  @override
  logout() async {
    (await _logoutUseCase.execute(null))
        .fold((l) => inputIsUserLogedOut.add(false), (r) async {
      initUser(r);
      await _appPreferences.logout();
      resetUser();
      inputIsUserLogedOut.add(true);
    });
  }

  @override
  updateProfil(
    String firstName,
    String lastName,
    String photo,
    Ville? ville,
    String? civilte,
    String phone,
    String password,
  ) async {
    (await _updateProfilUseCase.execute(UpdateProfilReques(
      civilite: (civilte != user.civilite) ? civilte : null,
      firstName: (firstName != user.firstName && firstName.isNotEmpty)
          ? firstName
          : null,
      lastName:
          (lastName != user.lastName && lastName.isNotEmpty) ? lastName : null,
      password: (password.isNotEmpty) ? password : null,
      phone: (phone != user.phone && phone.isNotEmpty) ? phone : null,
      photo: (photo != user.photo && photo.isNotEmpty) ? photo : null,
      villeId: (ville != null && ville.id != user.villeId) ? ville.id : null,
    )))
        .fold((l) {
      inputProfilUpdated.add(false);
    }, (r) {
      initUser(r);
      inputProfilUpdated.add(true);
    });
  }

  //outputs

  @override
  Stream<bool> get outputIsUserLogedOut =>
      isUserLogedOutStreamController.stream.map((event) => event);

  @override
  Stream<bool> get outputProfilUpdated =>
      isProfilUpdatedStreamController.stream.map((event) => event);

  @override
  Stream<bool> get outputIsPersonnelInfoOpen =>
      isPersonnelInfoOpenStreamController.stream.map((event) => event);

  @override
  Stream<bool> get outputIsSecuritelInfoOpen =>
      isSecuriteInfoOpenStreamController.stream.map((event) => event);
}

abstract class ProfilInput {
  Sink get inputIsPersonnelInfoOpen;

  Sink get inputIsSecuriteInfoOpen;

  Sink get inputIsUserLogedOut;

  Sink get inputProfilUpdated;

  logout();
  updateProfil(String firstName, String lastName, String photo, Ville? ville,
      String? civilte, String phone, String password);
}

abstract class ProfilOutput {
  Stream<bool> get outputIsPersonnelInfoOpen;

  Stream<bool> get outputIsSecuritelInfoOpen;

  Stream<bool> get outputIsUserLogedOut;

  Stream<bool> get outputProfilUpdated;
}
