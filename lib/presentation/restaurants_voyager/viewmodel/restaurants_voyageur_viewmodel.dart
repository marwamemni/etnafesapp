import 'dart:async';
import 'dart:math';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/restaurants%20use%20cases/get_restaurants_par_parametres_usease.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_pays_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_villes_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';

class RestaurantsVoyageurViewModel extends BaseViewModel
    with RestaurantsVoyageurViewModelInput, RestaurantsVoyageurViewModelOutput {
  StreamController paysStreamController =
      StreamController<List<Paye>>.broadcast();

  StreamController villesStreamController =
      StreamController<List<Ville>>.broadcast();

  StreamController restaurantsStreamController =
      StreamController<List<Restaurant>>.broadcast();
  final GetRestaurantsParParametreUseCase _getRestaurantsParParametreUseCase =
      instance<GetRestaurantsParParametreUseCase>();
  StreamController isFilterOpenedStreamController =
      StreamController<bool>.broadcast();
  StreamController isFilterUpdatedStreamController =
      StreamController<bool>.broadcast();

  final GetPaysUseCase _getPaysUseCase = instance<GetPaysUseCase>();
  final GetVillesUseCase _getvillesUseCase = instance<GetVillesUseCase>();
  List<Paye>? _pays;
  List<Ville>? _villes;
  // inputs
  @override
  void start() async {
    //  inputState.add(ContentState());
    await getPays();
    await getRestaurants();
  }

  @override
  void dispose() {
    restaurantsStreamController.close();
    paysStreamController.close();
    villesStreamController.close();
    isFilterOpenedStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inputIsFilterOpened => isFilterOpenedStreamController.sink;

  @override
  Sink get inputIsFilterUpdated => isFilterUpdatedStreamController.sink;
  @override
  Sink get inputPacks => restaurantsStreamController.sink;

  @override
  Sink get inputVilleId => villesStreamController.sink;

  @override
  Sink get inputPays => paysStreamController.sink;

  @override
  getRestaurants(
      {Ville? ville,
      String? type,
      DateTime? dateDebut,
      DateTime? dateFin,
      int? nbrPers}) async {
    String randomVilleId = "";
    if (ville == null && _pays != null) {
      Random x = Random();
      final String paye = _pays![x.nextInt(_pays!.length)].id;
      await setPaye(paye);
      if (_villes != null) {
        randomVilleId = _villes![x.nextInt(_villes!.length)].id;
      }
    }
    (await _getRestaurantsParParametreUseCase.execute(
      ville?.id ?? randomVilleId,
    ))
        .fold(
            (failure) => {
                  // left -> failure
                }, (data) {
      // right -> data (success)
      inputPacks.add(data);
    });
  }

  @override
  setPaye(String paye) async {
    (await _getvillesUseCase.execute(paye)).fold(
        (failure) => {
              // left -> failure
            }, (data) {
      // right -> data (success)
      // content
      _villes = data;
      // navigate to main screen
      inputVilleId.add(data);
      inputIsFilterUpdated.add(true);
    });
  }

  @override
  setVille(String ville) {
    inputIsFilterUpdated.add(true);
  }

  Future<void> getPays() async {
    (await _getPaysUseCase.execute(null)).fold((failure) {
      // left -> failure
    }, (data) {
      // right -> data (success)
      // content
      _pays = data;
      // navigate to main screen
      inputPays.add(data);
    });
  }

  // -- outputs

  @override
  Stream<List<Restaurant>> get outputRestaurants =>
      restaurantsStreamController.stream.map((list) => list);

  @override
  Stream<List<Paye>> get outputPays =>
      paysStreamController.stream.map((list) => list);

  @override
  Stream<List<Ville>> get outputvilles =>
      villesStreamController.stream.map((list) => list);

  @override
  Stream<bool> get outputIsFilterUpdated =>
      isFilterUpdatedStreamController.stream.map((event) => event);

  @override
  Stream<bool> get outputIsFilterOpened =>
      isFilterOpenedStreamController.stream.map((event) => event);
}

abstract class RestaurantsVoyageurViewModelInput {
  Sink get inputPacks;
  Sink get inputPays;
  Sink get inputIsFilterOpened;
  Sink get inputIsFilterUpdated;
  Sink get inputVilleId;
  setPaye(String paye);

  setVille(String ville);
  getRestaurants();
}

abstract class RestaurantsVoyageurViewModelOutput {
  Stream<List<Restaurant>> get outputRestaurants;
  Stream<List<Ville>> get outputvilles;
  Stream<bool> get outputIsFilterOpened;
  Stream<bool> get outputIsFilterUpdated;

  Stream<List<Paye>> get outputPays;
}
