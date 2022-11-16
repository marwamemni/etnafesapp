import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_pays_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_villes_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';

import '../../common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController paysStreamController =
      StreamController<List<Paye>>.broadcast();

  StreamController villesStreamController =
      StreamController<List<Ville>>.broadcast();

  StreamController dropDownValueStreamController =
      StreamController<void>.broadcast();
  final GetPaysUseCase _getPaysUseCase = instance<GetPaysUseCase>();
  final GetVillesUseCase _getvillesUseCase = instance<GetVillesUseCase>();

  // inputs
  @override
  void start() async {
    await getPays();
  }

  @override
  void dispose() {
    paysStreamController.close();
    villesStreamController.close();
    dropDownValueStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputVilleId => villesStreamController.sink;

  @override
  Sink get inputPays => paysStreamController.sink;

  @override
  Sink get inputDropDownValueChange => dropDownValueStreamController.sink;

  @override
  setPaye(String paye) async {
    (await _getvillesUseCase.execute(paye)).fold((failure) => {}, (data) {
      // right -> data (success)
      inputVilleId.add(data);
    });
  }

  @override
  setVille(String ville) {
    //TODO
  }

  Future<void> getPays() async {
    (await _getPaysUseCase.execute(null)).fold((failure) {}, (data) {
      // right -> data (success)
      inputPays.add(data);
    });
  }
  // -- outputs

  @override
  Stream<List<Paye>> get outputPays =>
      paysStreamController.stream.map((list) => list);

  @override
  Stream<List<Ville>> get outputvilles =>
      villesStreamController.stream.map((list) => list);

  @override
  Stream<void> get outputDropDownValueChange =>
      dropDownValueStreamController.stream.map((event) => event);
}

abstract class RegisterViewModelInput {
  Sink get inputPays;

  Sink get inputDropDownValueChange;

  Sink get inputVilleId;

  setPaye(String paye);

  setVille(String ville);
}

abstract class RegisterViewModelOutput {
  Stream<List<Ville>> get outputvilles;

  Stream<List<Paye>> get outputPays;

  Stream<void> get outputDropDownValueChange;
}
