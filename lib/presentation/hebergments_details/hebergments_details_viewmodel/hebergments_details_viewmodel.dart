import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/getUser_usecase.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/update_profil_usecase.dart';
import 'package:agence_voyage/domain/usecase/hebergments%20use%20cases/get_hebergment_usercase.dart';
import 'package:agence_voyage/domain/usecase/hebergments%20use%20cases/update_hebergment_usecase.dart';
import 'package:agence_voyage/domain/usecase/reservations%20use%20cases/post_reservation.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class HebergmentDetailsViewModel extends BaseViewModel
    with HebergmentDetailsViewModelInput, HebergmentDetailsViewModelOutput {
  StreamController hebergmentStreamController =
      StreamController<Hebergment>.broadcast();
  Hebergment? _hebergment;
  StreamController isInfoOpenStreamController =
      StreamController<bool>.broadcast();

  StreamController catgorieSectionChangedStreamController =
      StreamController<void>.broadcast();

  final GethebergmentUseCase _gethebergmentUseCase =
      instance<GethebergmentUseCase>();
  final PostReservatonUseCase _postReservatonUseCase =
      instance<PostReservatonUseCase>();
  final UpdateProfilUseCase _updateProfilUseCase =
      instance<UpdateProfilUseCase>();
  final UpdatehebergmentUseCase _updatehebergmentUseCase =
      instance<UpdatehebergmentUseCase>();
  final GetUserUseCase _getUserUseCase = instance<GetUserUseCase>();

  @override
  void start() {}

  @override
  void dispose() {
    hebergmentStreamController.close();
    isInfoOpenStreamController.close();
    catgorieSectionChangedStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inputHeberg => hebergmentStreamController.sink;

  @override
  Sink get inputIsInfoOpen => isInfoOpenStreamController.sink;

  @override
  Sink get inputCatgorieSectionChanged =>
      catgorieSectionChangedStreamController.sink;

  @override
  getheberg(String id) async {
    (await _gethebergmentUseCase.execute(id))
        .fold((l) {}, (r) => inputHeberg.add(r));
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
  postReservaton(
      Hebergment hebergement,
      DateTime dateDebut,
      DateTime dateFin,
      double prixTotal,
      int nbrPlace,
      int nbrChambre,
      List<int> chambreQuantityList) async {
    (await _getUserUseCase.execute(hebergement.proprietaireId)).fold((l) {},
        (proprietaire) async {
      (await _updatehebergmentUseCase.execute(UpdatehebergmentRequest(
        id: hebergement.id,
        nbrChambreDeux: hebergement.nbrChambreDeux - chambreQuantityList[1],
        nbrChambreDisp: hebergement.nbrChambreDisp - nbrChambre,
        nbrChambreIndiv: hebergement.nbrChambreIndiv - chambreQuantityList[0],
        nbrChambreTrois: hebergement.nbrChambreTrois - chambreQuantityList[2],
        nbrPlaceDisp: hebergement.nbrPlaceDisp - nbrPlace,
        nbrSuits: hebergement.nbrSuit - chambreQuantityList[3],
      )))
          .fold((l) {}, (r) async {
        (await _updateProfilUseCase
                .execute(UpdateProfilReques(point: user.points - prixTotal)))
            .fold((l) {}, (r) async {
          initUser(r);
          (await _updateProfilUseCase.execute(
                  UpdateProfilReques(point: proprietaire.points + prixTotal),
                  id: proprietaire.id))
              .fold((l) {}, (r) async {
            (await _postReservatonUseCase.execute(PostReservationRequest(
                    userId: user.id,
                    proprietaireId: proprietaire.id,
                    type: 'h1',
                    serviceId: hebergement.id,
                    nbrPersonne: nbrPlace,
                    dateDebut: dateDebut,
                    dateFin: dateFin)))
                .fold((l) {}, (r) {});
          });
        });
      });
    });
  }

  //outputs

  @override
  Stream<Hebergment> get outputheberg =>
      hebergmentStreamController.stream.map((event) {
        if (event != null) {
          _hebergment = event;
        }
        return _hebergment!;
      });

  @override
  Stream<bool> get outputIsInfoOpen =>
      isInfoOpenStreamController.stream.map((event) => event);

  @override
  Stream<void> get outputCatgorieSectionChanged =>
      catgorieSectionChangedStreamController.stream;
}

abstract class HebergmentDetailsViewModelInput {
  Sink get inputHeberg;
  Sink get inputIsInfoOpen;
  Sink get inputCatgorieSectionChanged;
  getheberg(String id);
  showPositionInMap(double? latitude, double? longitude);
  postReservaton(
      Hebergment hebergement,
      DateTime dateDebut,
      DateTime dateFin,
      double prixTotal,
      int nbrPlace,
      int nbrChambre,
      List<int> chambreQuantityList);
}

abstract class HebergmentDetailsViewModelOutput {
  Stream<Hebergment> get outputheberg;
  Stream<bool> get outputIsInfoOpen;
  Stream<void> get outputCatgorieSectionChanged;
}
