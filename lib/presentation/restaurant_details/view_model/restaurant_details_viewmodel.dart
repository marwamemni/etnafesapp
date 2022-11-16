import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/reservations%20use%20cases/post_reservation.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/usecase/restaurants use cases/get_restaurant_usecase.dart';

class RestaurantDetailsViewModel extends BaseViewModel
    with RestaurantDetailsViewModelInput, RestaurantDetailsViewModelOutput {
  StreamController restaurantStreamController =
      StreamController<Restaurant>.broadcast();
  StreamController viewInsetsBottomStreamController =
      StreamController<double>.broadcast();
  Restaurant? _restaurant;
  StreamController isInfoOpenStreamController =
      StreamController<bool>.broadcast();

  final GetRestaurantUseCase _getRestaurantUseCase =
      instance<GetRestaurantUseCase>();
  final PostReservatonUseCase _postReservatonUseCase =
      instance<PostReservatonUseCase>();

  @override
  void start() {}

  @override
  void dispose() {
    viewInsetsBottomStreamController.close();
    isInfoOpenStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inputIsInfoOpen => isInfoOpenStreamController.sink;

  @override
  Sink get inputRestaurant => restaurantStreamController.sink;

  @override
  Sink get inputViewInsetsBottom => viewInsetsBottomStreamController.sink;

  @override
  getRestaurant(String id) async {
    (await _getRestaurantUseCase.execute(id))
        .fold((l) {}, (r) => inputRestaurant.add(r));
  }

  @override
  showPositionInMap(double? latitude, double? longitude) async {
    if (latitude != null && longitude != null) {
      Uri? googleUrl;
      try {
        googleUrl = Uri.parse(
            'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
      } catch (_) {
        googleUrl = Uri.base;
      }
      if (await canLaunchUrl(googleUrl)) {
        await launchUrl(googleUrl);
      }
    }
  }

  @override
  postReservation(
      DateTime dateTime, int nbrPersonne, Restaurant restaurant) async {
    (await _postReservatonUseCase.execute(PostReservationRequest(
        userId: user.id,
        proprietaireId: restaurant.proprietaireId,
        type: 'r1',
        serviceId: restaurant.id,
        nbrPersonne: nbrPersonne,
        dateDebut: dateTime,
        dateFin: dateTime)));
  }

  //outputs

  @override
  Stream<double> get outputViewInsetsBottom =>
      viewInsetsBottomStreamController.stream.map((event) => event);

  @override
  Stream<Restaurant> get outputRestaurant =>
      restaurantStreamController.stream.map((event) {
        if (event != null) {
          _restaurant = event;
        }
        return _restaurant!;
      });

  @override
  Stream<bool> get outputIsInfoOpen =>
      isInfoOpenStreamController.stream.map((event) => event);
}

abstract class RestaurantDetailsViewModelInput {
  Sink get inputRestaurant;
  Sink get inputIsInfoOpen;
  Sink get inputViewInsetsBottom;
  getRestaurant(String id);
  showPositionInMap(double? latitude, double? longitude);
  postReservation(DateTime dateTime, int nbrPersonne, Restaurant restaurant);
}

abstract class RestaurantDetailsViewModelOutput {
  Stream<Restaurant> get outputRestaurant;
  Stream<bool> get outputIsInfoOpen;
  Stream<double> get outputViewInsetsBottom;
}
