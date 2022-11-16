// ignore_for_file: file_names

import 'dart:async' show Stream, StreamController;

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/restaurants%20use%20cases/delete_restaurant_usecase.dart';
import 'package:agence_voyage/domain/usecase/restaurants%20use%20cases/get_restaurant_par_proprieter_id_usecase.dart';

import 'package:agence_voyage/presentation/base/baseviewmodel.dart';

class HomePRestauxViewModel extends BaseViewModel
    with HomePRestauxViewModelInput, HomePRestauxViewModelOutput {
  StreamController restauxStreamController =
      StreamController<List<Restaurant>>.broadcast();

  final GetRestaurantsParProprietereIdUseCase
      _getRestaurantsParProprietereIdUseCase =
      instance<GetRestaurantsParProprietereIdUseCase>();
  final DeleteRestaurantUseCase _deleteRestaurantUseCase =
      instance<DeleteRestaurantUseCase>();

  List<Restaurant>? _restauxList;
  // inputs
  @override
  void start() async {
    await getRestaux();
  }

  @override
  void dispose() {
    restauxStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inputRestaux => restauxStreamController.sink;

  @override
  getRestaux() async {
    (await _getRestaurantsParProprietereIdUseCase.execute(user.id)).fold(
        (failure) => {
              // left -> failure
            }, (data) {
      // right -> data (success)
      // content
      // navigate to main screen
      inputRestaux.add(data);
    });
  }

  @override
  deleteRestaurant(String id) async {
    (await _deleteRestaurantUseCase.execute(id)).fold((l) {}, (r) {
      if (r) {
        _restauxList!
            .remove(_restauxList!.firstWhere((element) => element.id == id));
        inputRestaux.add(_restauxList);
      }
    });
  }

  // -- outputs

  @override
  Stream<List<Restaurant>> get outputRestaux =>
      restauxStreamController.stream.map((list) {
        if (list != null) {
          _restauxList = list;
        }
        return _restauxList!;
      });
}

abstract class HomePRestauxViewModelInput {
  Sink get inputRestaux;
  deleteRestaurant(String id);
  getRestaux();
}

abstract class HomePRestauxViewModelOutput {
  Stream<List<Restaurant>> get outputRestaux;
}
