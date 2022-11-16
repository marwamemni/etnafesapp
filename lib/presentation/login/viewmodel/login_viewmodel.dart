import 'dart:async';
import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/app/functions.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/forgot_password_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';
import 'package:agence_voyage/presentation/common/state_renderer/state_renderer_impl.dart';
import '../../../domain/usecase/authentication use cases/login_usecase.dart';
import '../../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>.broadcast();

  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  LoginViewModel(this._loginUseCase, this._forgotPasswordUseCase);

  // inputs
  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // view model should tell view please show content state
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  Sink get isUserLoggedIn => isUserLoggedInSuccessfullyStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  setEmail(String email) {
    if (isEmailValid(email)) {
      inputEmail.add(email);
    } else {
      inputEmail.add("");
    }
    loginObject = loginObject.copyWith(userName: email);
    inputAreAllInputsValid.add(null);
  }

  @override
  login() async {
    // inputState.add(
    //     LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _loginUseCase.execute(loginObject)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(failure.message))
            }, (data) {
      // right -> data (success)
      // content
      initUser(data);
      // navigate to main screen
      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  forgotPassword() async {
    if (isEmailValid(loginObject.userName)) {
      (await _forgotPasswordUseCase.execute(loginObject.userName)).fold(
          (failure) {
        inputState.add(ErrorState(failure.message));
      }, (supportMessage) {
        if (supportMessage) {
          inputState.add(SuccessState("reset link sent to your email"));
        } else {
          inputState.add(ErrorState("something want wrong"));
        }
      });
    } else {
      inputState.add(ErrorState("enter valid email"));
    }
  }

  // outputs
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outIsUserLoggedIn =>
      isUserLoggedInSuccessfullyStreamController.stream.map((event) => event);

  //private functions

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _areAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        isEmailValid(loginObject.userName);
  }
}

abstract class LoginViewModelInputs {
  forgotPassword();

  setEmail(String email);

  setPassword(String password);

  login();

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputAreAllInputsValid;

  Sink get isUserLoggedIn;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsEmailValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outAreAllInputsValid;

  Stream<bool> get outIsUserLoggedIn;
}
