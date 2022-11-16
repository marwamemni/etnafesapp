import 'package:agence_voyage/app/constants.dart';
import 'package:agence_voyage/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}
// loading state (POPUP,)

class LoadingState extends FlowState {
  String? message;

  LoadingState({String message = 'loading'});

  @override
  String getMessage() => message ?? 'loading';

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.popupLoadingState;
}

// error state (POPUP,)
class ErrorState extends FlowState {
  String message;

  ErrorState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupErrorState;
}

// success state
class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccess;
}

extension FlowStateExtension on FlowState {
  void getScreenWidget(BuildContext context, Function? retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          // show popup loading
          showPopup(context, getStateRendererType(), getMessage());
          // show content ui of the screen
          break;
        }
      case ErrorState:
        {
          dismissDialog(context);
          // show popup error
          showPopup(context, getStateRendererType(), getMessage());
          // show content ui of the screen
          break;
        }
      case SuccessState:
        {
          // i should check if we are showing loading popup to remove it before showing success popup
          dismissDialog(context);

          // show popup
          showPopup(context, StateRendererType.popupSuccess, getMessage(),
              title: 'Success');
          // return content ui of the screen
          break;
        }
      default:
        {
          break;
        }
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context) && Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }
}

showPopup(
    BuildContext context, StateRendererType stateRendererType, String message,
    {String title = Constants.empty}) {
  WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
      context: context,
      builder: (BuildContext context) => getStateWidget(
            context,
            stateRendererType,
            message: message,
            title: title,
          )));
}
