import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/packages%20use%20cases/delete_pack_usecase.dart';
import 'package:agence_voyage/domain/usecase/packages%20use%20cases/get_packs_par_propietere_id_usecase.dart';

import 'package:agence_voyage/presentation/base/baseviewmodel.dart';

class HomeAdminViewModel extends BaseViewModel
    with HomeAdminViewModelInput, HomeAdminViewModelOutput {
  StreamController packsStreamController =
      StreamController<List<Pack>>.broadcast();

  final GetPacksParProrietereIdUseCase _getPacksParProrietereIdUseCase =
      instance<GetPacksParProrietereIdUseCase>();
  final DeletePackUseCase _deletePackUseCase = instance<DeletePackUseCase>();

  List<Pack>? _packList;
  // inputs
  @override
  void start() async {
    await getPacks();
  }

  @override
  void dispose() {
    packsStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inputPacks => packsStreamController.sink;

  @override
  getPacks() async {
    (await _getPacksParProrietereIdUseCase.execute(user.id)).fold(
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
  deletePack(String id) async {
    (await _deletePackUseCase.execute(id)).fold((l) {}, (r) {
      if (r) {
        _packList!.remove(_packList!.firstWhere((element) => element.id == id));
        inputPacks.add(_packList);
      }
    });
  }

  // -- outputs

  @override
  Stream<List<Pack>> get outputpacks =>
      packsStreamController.stream.map((list) {
        if (list != null) {
          _packList = list;
        }
        return _packList!;
      });
}

abstract class HomeAdminViewModelInput {
  Sink get inputPacks;
  deletePack(String id);
  getPacks();
}

abstract class HomeAdminViewModelOutput {
  Stream<List<Pack>> get outputpacks;
}
