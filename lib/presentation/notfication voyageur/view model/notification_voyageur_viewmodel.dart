import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/getUser_usecase.dart';
import 'package:agence_voyage/domain/usecase/reservations%20use%20cases/get_user_reservation_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';
import '../../../data/network/requests.dart';
import '../../../domain/usecase/reservations use cases/update_reservatiom_usecase.dart';

class NotificationVoyageurViewModel extends BaseViewModel
    with
        NotificationVoyageurViewModelInput,
        NotificationVoyageurViewModelOutput {
  StreamController notifsStreamController =
      StreamController<List<Reservation>>.broadcast();

  final GetUserReservatonUseCase _getReservationUseCase =
      instance<GetUserReservatonUseCase>();
  final GetUserUseCase _getUserUseCase = instance<GetUserUseCase>();
  final UpdateReservationUseCase _updateReservationUseCase =
      instance<UpdateReservationUseCase>();

  Authentication? client;
  List<Reservation>? _reservations;

  // inputs
  @override
  void start() async {
    await getNotifs();
  }

  @override
  void dispose() {
    notifsStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inputnotifs => notifsStreamController.sink;

  @override
  getNotifs() async {
    (await _getReservationUseCase.execute(
            user.userType == UserType.voyageur.name
                ? GetReservationParParametreRequest(userId: user.id)
                : user.userType == UserType.adminAgence.name
                    ? GetReservationParParametreRequest(
                        proprietaireId: user.id, type: "p1")
                    : user.userType == UserType.prorietereResto.name
                        ? GetReservationParParametreRequest(
                            proprietaireId: user.id, type: "r1")
                        : GetReservationParParametreRequest(
                            proprietaireId: user.id, type: "h1")))
        .fold(
            (failure) => {
                  // left -> failure
                }, (data) {
      // right -> data (success)
      inputnotifs.add(data);
    });
  }

  @override
  getClient(String id) async {
    (await _getUserUseCase.execute(id)).fold((l) {}, (r) {
      client = r;
    });
  }

  @override
  confirmeNotification(String id) async {
    (await _updateReservationUseCase.execute(UpdateReservationRequest(
            id,
            user.userType == UserType.adminAgence.name
                ? 'p2'
                : user.userType == UserType.prorietereHeberg.name
                    ? 'h2'
                    : 'r2')))
        .fold((l) {}, (r) {
      _reservations!.removeWhere((element) => element.id == id);

      inputnotifs.add(_reservations);
    });
  }

  //outputs

  @override
  Stream<List<Reservation>> get outputnotification =>
      notifsStreamController.stream.map((list) {
        if (list != null) {
          _reservations = list;
        }
        return _reservations!;
      });
}

abstract class NotificationVoyageurViewModelInput {
  Sink get inputnotifs;

  getNotifs();
  getClient(String id);
  confirmeNotification(String id);
}

abstract class NotificationVoyageurViewModelOutput {
  Stream<List<Reservation>> get outputnotification;
}
