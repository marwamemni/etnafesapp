import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/getUser_usecase.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/update_profil_usecase.dart';
import 'package:agence_voyage/domain/usecase/hebergments%20use%20cases/get_hebergment_usercase.dart';
import 'package:agence_voyage/domain/usecase/packages%20use%20cases/get_pack_usecase.dart';
import 'package:agence_voyage/domain/usecase/packages%20use%20cases/update_pack_usecase.dart';
import 'package:agence_voyage/domain/usecase/reservations%20use%20cases/post_reservation.dart';
import 'package:agence_voyage/domain/usecase/restaurants%20use%20cases/get_restaurant_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';

class PackDetailsViewModel extends BaseViewModel
    with PackDetailsViewModelInput, PackDetailsViewModelOutput {
  StreamController hebergmentsStreamController =
      StreamController<List<Hebergment>>.broadcast();
  StreamController restauxStreamController =
      StreamController<List<Restaurant>>.broadcast();
  StreamController isActiviteOpenStreamController =
      StreamController<bool>.broadcast();
  StreamController packStreamController = StreamController<Pack>.broadcast();
  StreamController viewInsetsBottomStreamController =
      StreamController<double>.broadcast();

  Pack? _pack;
  List<Hebergment>? _hebergments;
  List<Restaurant>? _restaux;

  final GetPackUseCase _getPackUseCase = instance<GetPackUseCase>();
  final GethebergmentUseCase _gethebergmentUseCase =
      instance<GethebergmentUseCase>();
  final GetRestaurantUseCase _getRestaurantUseCase =
      instance<GetRestaurantUseCase>();
  final PostReservatonUseCase _postReservatonUseCase =
      instance<PostReservatonUseCase>();
  final UpdateProfilUseCase _updateProfilUseCase =
      instance<UpdateProfilUseCase>();
  final UpDatePackUseCase _updatePackUseCase = instance<UpDatePackUseCase>();
  final GetUserUseCase _getUserUseCase = instance<GetUserUseCase>();

  @override
  void start() async {
    await getheberg(_pack!.hebergments);
    await getRestaux(_pack!.restaurants);
  }

  @override
  void dispose() {
    hebergmentsStreamController.close();
    isActiviteOpenStreamController.close();
    restauxStreamController.close();
    packStreamController.close();
    // catgorieSectionChangedStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inputRestaux => restauxStreamController.sink;

  @override
  Sink get inputViewInsetsBottom => viewInsetsBottomStreamController.sink;

  @override
  Sink get inputHeberg => hebergmentsStreamController.sink;

  @override
  Sink get inputIsActiviteOpen => isActiviteOpenStreamController.sink;

  @override
  Sink get inputPack => packStreamController.sink;

  @override
  getheberg(List<String> idList) async {
    List<Hebergment> hebList = [];
    for (String id in idList) {
      (await _gethebergmentUseCase.execute(id))
          .fold((l) {}, (r) => hebList.add(r));
    }
    inputHeberg.add(hebList);
  }

  @override
  postReservaton(
    Pack pack,
    int nbrPlace,
  ) async {
    (await _getUserUseCase.execute(pack.proprietaireId)).fold((l) {},
        (proprietaire) async {
      (await _updatePackUseCase.execute(UpDatePackRequest(
        id: pack.id,
        nbrPlace: pack.nbrPlaceDisp - nbrPlace,
      )))
          .fold((l) {}, (r) async {
        (await _updateProfilUseCase.execute(
                UpdateProfilReques(point: user.points - pack.prix * nbrPlace)))
            .fold((l) {}, (r) async {
          initUser(r);
          (await _updateProfilUseCase.execute(
                  UpdateProfilReques(
                      point: proprietaire.points + pack.prix * nbrPlace),
                  id: proprietaire.id))
              .fold((l) {}, (r) async {
            (await _postReservatonUseCase.execute(PostReservationRequest(
                    userId: user.id,
                    proprietaireId: proprietaire.id,
                    type: 'p1',
                    serviceId: pack.id,
                    nbrPersonne: nbrPlace,
                    dateDebut: pack.dateDebut,
                    dateFin: pack.dateFin)))
                .fold((l) {}, (r) {});
          });
        });
      });
    });
  }

  @override
  Future<Authentication> getProprieter(String proprietaireId) async {
    Authentication authentication = Authentication(
        '', '', '', UserType.visiteur.name, '', '', '', 0, '', '');
    (await _getUserUseCase.execute(proprietaireId))
        .fold((l) {}, (r) => authentication = r);
    return authentication;
  }

  @override
  getRestaux(List<String> idList) async {
    List<Restaurant> resList = [];
    for (String id in idList) {
      (await _getRestaurantUseCase.execute(id))
          .fold((l) {}, (r) => resList.add(r));
    }
    inputRestaux.add(resList);
  }

  @override
  getPack(String id) async {
    (await _getPackUseCase.execute(id)).fold((l) {}, (r) => inputPack.add(r));
  }

  //outputs

  @override
  Stream<bool> get outputIsActiviteOpen =>
      isActiviteOpenStreamController.stream.map((event) => event);

  @override
  Stream<double> get outputViewInsetsBottom =>
      viewInsetsBottomStreamController.stream.map((event) => event);

  @override
  Stream<List<Hebergment>> get outputhebergs =>
      hebergmentsStreamController.stream.map((event) {
        if (event != null && event != []) {
          _hebergments = event;
        }
        return _hebergments!;
      });

  @override
  Stream<Pack> get outputPack => packStreamController.stream.map((event) {
        if (event != null) {
          _pack = event;
        }
        return _pack!;
      });

  @override
  Stream<List<Restaurant>> get outputRestaux =>
      restauxStreamController.stream.map((event) {
        if (event != null && event != []) {
          _restaux = event;
        }
        return _restaux!;
      });
}

abstract class PackDetailsViewModelInput {
  Sink get inputHeberg;
  Sink get inputIsActiviteOpen;
  Sink get inputPack;
  Sink get inputRestaux;
  Sink get inputViewInsetsBottom;
  // Sink get inputCatgorieSectionChanged;
  getheberg(List<String> idList);
  // showPositionInMap(double? latitude, double? longitude);
  postReservaton(
    Pack pack,
    int nbrPlace,
  );
  getPack(String id);
  Future<Authentication> getProprieter(String proprietaireId);
  getRestaux(List<String> idList);
}

abstract class PackDetailsViewModelOutput {
  Stream<List<Hebergment>> get outputhebergs;
  Stream<bool> get outputIsActiviteOpen;
  Stream<Pack> get outputPack;
  Stream<List<Restaurant>> get outputRestaux;
  Stream<double> get outputViewInsetsBottom;
}
