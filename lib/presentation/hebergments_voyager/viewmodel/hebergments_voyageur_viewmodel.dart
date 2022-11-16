import 'dart:async';
import 'dart:math';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/hebergments%20use%20cases/get_hebergments_par_parametres_usease.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_pays_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_villes_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';

class HebergmentsVoyageurViewModel extends BaseViewModel
    with HebergmentsVoyageurViewModelInput, HebergmentsVoyageurViewModelOutput {
  StreamController paysStreamController =
      StreamController<List<Paye>>.broadcast();

  StreamController villesStreamController =
      StreamController<List<Ville>>.broadcast();

  StreamController typesStreamController = StreamController<void>.broadcast();
  StreamController hebergmentsStreamController =
      StreamController<List<Hebergment>>.broadcast();
  final GethebergmentsParParametreUseCase _gethebergmentsParParametreUseCase =
      instance<GethebergmentsParParametreUseCase>();
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
    await gethebergs();
  }

  @override
  void dispose() {
    hebergmentsStreamController.close();
    paysStreamController.close();
    villesStreamController.close();
    isFilterOpenedStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inputVilleId => villesStreamController.sink;

  @override
  Sink get inputPays => paysStreamController.sink;

  @override
  Sink get inputHebergs => hebergmentsStreamController.sink;

  @override
  Sink get inputIsFilterOpened => isFilterOpenedStreamController.sink;

  @override
  Sink get inputIsFilterUpdated => isFilterUpdatedStreamController.sink;

  @override
  Sink get inputTypes => typesStreamController.sink;

  @override
  setVille(String ville) {
    inputIsFilterUpdated.add(true);
  }

  @override
  gethebergs(
      {Paye? paye,
      Ville? ville,
      String? type,
      DateTime? dateDebut,
      DateTime? dateFin,
      int? nbrPers}) async {
    String randomVilleId = "";
    if (ville == null && _pays != null) {
      Random x = Random();
      final String randomPaye = _pays![x.nextInt(_pays!.length)].id;
      await setPaye(randomPaye);
      if (_villes != null) {
        randomVilleId = _villes![x.nextInt(_villes!.length)].id;
      }
    }
    (await _gethebergmentsParParametreUseCase
            .execute(GethebergmentsParParametreRequest(
      ville: ville?.id ?? randomVilleId,
      categorie: type,
      dateDebut: dateDebut,
      dateFin: dateFin,
      nbrPersonnes: nbrPers,
    )))
        .fold((failure) => {}, (data) {
      inputHebergs.add(data);
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

  // -- outputs

  @override
  Stream<List<Hebergment>> get outputhebergs =>
      hebergmentsStreamController.stream.map((list) => list);

  @override
  Stream<bool> get outputIsFilterOpened =>
      isFilterOpenedStreamController.stream.map((event) => event);

  @override
  Stream<bool> get outputIsFilterUpdated =>
      isFilterUpdatedStreamController.stream.map((event) => event);

  @override
  Stream<List<Paye>> get outputPays =>
      paysStreamController.stream.map((list) => list);

  @override
  Stream<List<Ville>> get outputvilles =>
      villesStreamController.stream.map((list) => list);

  @override
  Stream<List<String>> get outputTypes =>
      typesStreamController.stream.map((_) => ['Hotel', 'Motel']);
}

abstract class HebergmentsVoyageurViewModelInput {
  Sink get inputHebergs;
  Sink get inputPays;
  Sink get inputVilleId;
  Sink get inputTypes;
  Sink get inputIsFilterOpened;
  Sink get inputIsFilterUpdated;
  setPaye(String paye);

  setVille(String ville);
  gethebergs();
}

abstract class HebergmentsVoyageurViewModelOutput {
  Stream<List<Hebergment>> get outputhebergs;
  Stream<List<Ville>> get outputvilles;
  Stream<List<String>> get outputTypes;
  Stream<bool> get outputIsFilterOpened;
  Stream<bool> get outputIsFilterUpdated;

  Stream<List<Paye>> get outputPays;
}
