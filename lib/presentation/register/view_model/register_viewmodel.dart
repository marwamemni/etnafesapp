import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/register_usecase.dart';
import 'package:agence_voyage/domain/usecase/images%20use%20cases/store_image_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_pays_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_villes_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/functions.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController paysStreamController =
      StreamController<List<Paye>>.broadcast();

  StreamController villesStreamController =
      StreamController<List<Ville>>.broadcast();

  StreamController civiliteStreamController =
      StreamController<void>.broadcast();

  StreamController dropDownValueStreamController =
      StreamController<void>.broadcast();

  StreamController emailStreamController = StreamController<String>.broadcast();

  StreamController passwordStreamController =
      StreamController<String>.broadcast();

  StreamController profilePictureStreamController =
      StreamController<String>.broadcast();

  StreamController areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  StreamController isUserRegisteredInSuccessfullyStreamController =
      StreamController<bool>();
  final RegisterUseCase _registerUseCase;
  final GetPaysUseCase _getPaysUseCase = instance<GetPaysUseCase>();
  final GetVillesUseCase _getvillesUseCase = instance<GetVillesUseCase>();
  final StoreImageUseCase _storeImageUseCase = instance<StoreImageUseCase>();
  var registerObject =
      RegisterObject("", "", "", "", "", UserType.voyageur.name, "", "", "", 0);

  RegisterViewModel(this._registerUseCase);

  // inputs
  @override
  void start() async {
    //  inputState.add(ContentState());
    await getPays();
    inputCivility.add(null);
  }

  @override
  void dispose() {
    paysStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    villesStreamController.close();
    civiliteStreamController.close();
    profilePictureStreamController.close();
    areAllInputsValidStreamController.close();
    isUserRegisteredInSuccessfullyStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  Sink get inputAllInputsValid => areAllInputsValidStreamController.sink;

  @override
  Sink get inputCivility => civiliteStreamController.sink;

  @override
  Sink get inputVilleId => villesStreamController.sink;

  @override
  Sink get inputPays => paysStreamController.sink;
  @override
  register() async {
    (await _registerUseCase.execute(registerObject)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(failure.message))
            }, (data) {
      // right -> data (success)
      // content
      initUser(data);
      // navigate to main screen
      isUserRegisteredInSuccessfullyStreamController.add(true);
    });
  }

  @override
  setFirstName(String firstName) {
    registerObject = registerObject.copyWith(firstName: firstName);
    validate();
  }

  @override
  setLastName(String lastName) {
    registerObject = registerObject.copyWith(lastName: lastName);
    validate();
  }

  @override
  setVille(String ville) {
    registerObject = registerObject.copyWith(villeId: ville);
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      //  update register view object
      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    registerObject = registerObject.copyWith(phone: mobileNumber);
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      //  update register view object
      registerObject = registerObject.copyWith(password: password);
    } else {
      // reset password value in register view object
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(XFile profilePicture) async {
    (await _storeImageUseCase.execute(profilePicture)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(failure.message))
            }, (data) {
      // right -> data (success)
      // content
      // navigate to main screen
      registerObject = registerObject.copyWith(photo: data);
      inputProfilePicture.add(data);
    });
    validate();
  }

  @override
  setCivilite(String civilite) {
    inputCivility.add(civilite);
    registerObject = registerObject.copyWith(civilite: civilite);
    validate();
  }

  @override
  setPaye(String paye) async {
    (await _getvillesUseCase.execute(paye)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(failure.message))
            }, (data) {
      // right -> data (success)
      // navigate to main screen
      inputVilleId.add(data);
    });
  }

  // -- outputs

  @override
  Stream<bool> get outputIsEmailValid =>
      emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<List<Ville>> get outputvilles =>
      villesStreamController.stream.map((list) => list);

  @override
  Stream<bool> get outputIsPasswordValid => passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String> get outputProfilePicture =>
      profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputAreAllInputsValid =>
      areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  @override
  Stream<List<Paye>> get outputPays =>
      paysStreamController.stream.map((list) => list);

  @override
  Stream<List<String>> get outputcivilites =>
      civiliteStreamController.stream.map((_) {
        return [
          Civilite.celibataire.name,
          Civilite.marie.name,
        ];
      });

  // --  private functions

  Future<void> getPays() async {
    (await _getPaysUseCase.execute(null)).fold((failure) {}, (data) {
      // right -> data (success)

      inputPays.add(data);
    });
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _areAllInputsValid() {
    return registerObject.villeId.isNotEmpty &&
        registerObject.phone.isNotEmpty &&
        registerObject.firstName.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.photo.isNotEmpty &&
        registerObject.civilite.isNotEmpty;
  }

  validate() {
    inputAllInputsValid.add(null);
  }

  @override
  Sink get inputDropDownValueChange => dropDownValueStreamController.sink;

  @override
  Stream<void> get outputDropDownValueChange =>
      dropDownValueStreamController.stream.map((event) => event);

  @override
  Sink get isUserLoggedIn =>
      isUserRegisteredInSuccessfullyStreamController.sink;

  @override
  Stream<bool> get outIsUserLoggedIn =>
      isUserRegisteredInSuccessfullyStreamController.stream
          .map((event) => event);
}

abstract class RegisterViewModelInput {
  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfilePicture;

  Sink get inputAllInputsValid;

  Sink get inputVilleId;

  Sink get inputCivility;

  Sink get inputPays;

  Sink get inputDropDownValueChange;

  Sink get isUserLoggedIn;

  register();

  setFirstName(String firstName);

  setLastName(String lastName);

  setMobileNumber(String mobileNumber);

  setEmail(String email);

  setPassword(String password);

  setCivilite(String civilite);

  setPaye(String paye);

  setVille(String ville);

  setProfilePicture(XFile profilePicture);
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<List<Ville>> get outputvilles;

  Stream<List<String>> get outputcivilites;

  Stream<String> get outputProfilePicture;

  Stream<bool> get outputAreAllInputsValid;

  Stream<List<Paye>> get outputPays;

  Stream<void> get outputDropDownValueChange;

  Stream<bool> get outIsUserLoggedIn;
}
