import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/hebergments%20use%20cases/delete_hebergment_usecase.dart';
import 'package:agence_voyage/domain/usecase/hebergments%20use%20cases/get_hebergments_par_prorietere_id.dart';

import 'package:agence_voyage/presentation/base/baseviewmodel.dart';

class HomeHebergerViewModel extends BaseViewModel
    with HomeHebergerViewModelInput, HomeHebergerViewModelOutput {
  StreamController hebergmentsStreamController =
      StreamController<List<Hebergment>>.broadcast();

  final GethebergmentsParProprietaireUseCase
      _gethebergmentsParProrieterIdUseCase =
      instance<GethebergmentsParProprietaireUseCase>();
  final DeletehebergmentUseCase _deletehebergmentUseCase =
      instance<DeletehebergmentUseCase>();

  List<Hebergment>? _hebergmentList;
  // inputs
  @override
  void start() async {
    await gethebergs();
  }

  @override
  void dispose() {
    hebergmentsStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inputHebergs => hebergmentsStreamController.sink;

  @override
  gethebergs() async {
    (await _gethebergmentsParProrieterIdUseCase.execute(user.id)).fold(
        (failure) => {
              // left -> failure
            }, (data) {
      // right -> data (success)
      // content
      inputHebergs.add(data);
    });
  }

  @override
  deleteHeberg(String id) async {
    (await _deletehebergmentUseCase.execute(id)).fold((l) {}, (r) {
      if (r) {
        _hebergmentList!
            .remove(_hebergmentList!.firstWhere((element) => element.id == id));
        inputHebergs.add(_hebergmentList);
      }
    });
  }

  // -- outputs

  @override
  Stream<List<Hebergment>> get outputhebergs =>
      hebergmentsStreamController.stream.map((list) {
        if (list != null) {
          _hebergmentList = list;
        }
        return _hebergmentList!;
      });
}

abstract class HomeHebergerViewModelInput {
  Sink get inputHebergs;
  deleteHeberg(String id);
  gethebergs();
}

abstract class HomeHebergerViewModelOutput {
  Stream<List<Hebergment>> get outputhebergs;
}
