import 'dart:async';
import 'dart:math';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/packages%20use%20cases/get_packages_par_parametres_usease.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_pays_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_villes_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';

class PacksVoyageurViewModel extends BaseViewModel
    with PacksVoyageurViewModelInput, PacksVoyageurViewModelOutput {
  StreamController paysStreamController =
      StreamController<List<Paye>>.broadcast();

  StreamController villesStreamController =
      StreamController<List<Ville>>.broadcast();

  StreamController typesStreamController = StreamController<void>.broadcast();
  StreamController packsStreamController =
      StreamController<List<Pack>>.broadcast();
  final GetPacksParParametreUseCase _getPacksParParametreUseCase =
      instance<GetPacksParParametreUseCase>();
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
    await getPays();
    await getPacks();
  }

  @override
  void dispose() {
    packsStreamController.close();
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
  Sink get inputPacks => packsStreamController.sink;

  @override
  Sink get inputVilleId => villesStreamController.sink;

  @override
  Sink get inputPays => paysStreamController.sink;

  @override
  getPacks(
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
    (await _getPacksParParametreUseCase.execute(GetPacksParParametreRequest(
      ville: ville?.id ?? randomVilleId,
      dateDebut: dateDebut,
      dateFin: dateFin,
      nbrPersonnes: nbrPers,
    )))
        .fold(
            (failure) => {
                  // left -> failure
                }, (data) {
      // right -> data (success)
      // content
      // navigate to main screen
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

  @override
  setVille(String ville) {
    inputIsFilterUpdated.add(true);
  }

  // -- outputs

  @override
  Stream<List<Ville>> get outputvilles =>
      villesStreamController.stream.map((list) => list);

  @override
  Stream<bool> get outputIsFilterOpened =>
      isFilterOpenedStreamController.stream.map((event) => event);

  @override
  Stream<List<Paye>> get outputPays =>
      paysStreamController.stream.map((list) => list);

  @override
  Stream<List<Pack>> get outputPacks =>
      packsStreamController.stream.map((list) => list);

  @override
  Stream<bool> get outputIsFilterUpdated =>
      isFilterUpdatedStreamController.stream.map((event) => event);
}

abstract class PacksVoyageurViewModelInput {
  Sink get inputPacks;
  Sink get inputPays;
  Sink get inputIsFilterOpened;
  Sink get inputIsFilterUpdated;
  Sink get inputVilleId;
  setPaye(String paye);

  setVille(String ville);
  getPacks();
}

abstract class PacksVoyageurViewModelOutput {
  Stream<List<Pack>> get outputPacks;
  Stream<List<Ville>> get outputvilles;
  Stream<bool> get outputIsFilterOpened;
  Stream<bool> get outputIsFilterUpdated;

  Stream<List<Paye>> get outputPays;
}
