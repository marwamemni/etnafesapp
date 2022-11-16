import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/hebergments%20use%20cases/update_hebergment_usecase.dart';
import 'package:agence_voyage/domain/usecase/images%20use%20cases/delete_image_usecase.dart';
import 'package:agence_voyage/domain/usecase/images%20use%20cases/store_image_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/usecase/hebergments use cases/get_hebergment_usercase.dart';

class EditHebergmentViewModel extends BaseViewModel
    with EditHebergmentViewModelInput, EditHebergmentViewModelOutput {
  final StreamController _photoStreamController =
      StreamController<String>.broadcast();
  final StreamController _isHebergmentUpdatedStreamController =
      StreamController<bool>.broadcast();
  final StreamController _hebergmentStreamController =
      StreamController<Hebergment>.broadcast();

  final UpdatehebergmentUseCase _updatehebergmentUseCase =
      instance<UpdatehebergmentUseCase>();
  final StoreImageUseCase _storeImageUseCase = instance<StoreImageUseCase>();
  final DeleteImageUseCase _deleteImageUseCase = instance<DeleteImageUseCase>();
  final GethebergmentUseCase _gethebergmentUseCase =
      instance<GethebergmentUseCase>();

  // ignore: prefer_final_fields
  List<String>? _photos;
  Hebergment? _hebergment;

  @override
  void start() async {}

  @override
  void dispose() {
    _isHebergmentUpdatedStreamController.close();
    _photoStreamController.close();
    _hebergmentStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inpuIsHebergmentUpdated => _isHebergmentUpdatedStreamController.sink;

  @override
  Sink get inputPhotos => _photoStreamController.sink;

  @override
  Sink get inputHeberg => _hebergmentStreamController.sink;

  @override
  updateHebergment(
      {required String name,
      required int nbrVoyager,
      required int nbrChambreDisp,
      required int nbrChambreIndiv,
      required int nbrChambreDeux,
      required int nbrChambreTrois,
      required int nbrSuit,
      required double prixChambreIndiv,
      required double prixChambreDeux,
      required double prixChambreTrois,
      required double prixSuit,
      required String description,
      required String photoCoverture,
      required double latitude,
      required double longitude,
      required DateTime dateDebut,
      required DateTime dateFin}) async {
    _photos!.remove('');
    (await _updatehebergmentUseCase.execute(UpdatehebergmentRequest(
      id: _hebergment!.id,
      name: name,
      villeId: _hebergment!.villeId,
      nbrVoyager: nbrVoyager,
      nbrPlaceDisp: nbrVoyager,
      nbrChambreDisp: nbrChambreDisp,
      nbrChambreIndiv: nbrChambreIndiv,
      nbrChambreDeux: nbrChambreDeux,
      nbrChambreTrois: nbrChambreTrois,
      nbrSuits: nbrSuit,
      prixChambreIndiv: prixChambreIndiv,
      prixChambreDeux: prixChambreDeux,
      prixChambreTrois: prixChambreTrois,
      prixSuit: prixSuit,
      categorie: _hebergment!.categorie,
      description: description,
      photoCoverture: photoCoverture,
      latitude: latitude,
      longitude: longitude,
      photos: _photos,
      dateDebut: dateDebut,
      dateFin: dateFin,
    )))
        .fold((l) {}, (r) {
      inpuIsHebergmentUpdated.add(true);
    });
  }

  @override
  addPhoto(XFile photo) async {
    (await _storeImageUseCase.execute(photo)).fold((l) {}, (r) {
      inputPhotos.add(r);
    });
  }

  @override
  deletePhoto(String photo) async {
    (await _deleteImageUseCase.execute(photo)).fold((l) {}, (r) {
      _photos!.remove(photo);
      inputPhotos.add('');
    });
  }

  @override
  getheberg(String id) async {
    (await _gethebergmentUseCase.execute(id)).fold((l) {}, (r) {
      _photos = r.photos;

      inputHeberg.add(r);
    });
    await Future.delayed(const Duration(seconds: 1));
    inputPhotos.add('');
  }

  //outputs
  @override
  Stream<Hebergment> get outputheberg =>
      _hebergmentStreamController.stream.map((event) {
        if (event != null) {
          _hebergment = event;
        }
        return _hebergment!;
      });

  @override
  Stream<bool> get outputIsHebergmentUpdated =>
      _isHebergmentUpdatedStreamController.stream.map((event) => event);

  @override
  Stream<List<String>> get outputPhoto =>
      _photoStreamController.stream.map((event) {
        if (event != null && event != '') {
          _photos!.add(event);
        }
        return _photos!;
      });
}

abstract class EditHebergmentViewModelInput {
  Sink get inputPhotos;

  Sink get inpuIsHebergmentUpdated;
  Sink get inputHeberg;
  addPhoto(XFile photo);
  deletePhoto(String photo);
  getheberg(String id);
  updateHebergment(
      {required String name,
      required int nbrVoyager,
      required int nbrChambreDisp,
      required int nbrChambreIndiv,
      required int nbrChambreDeux,
      required int nbrChambreTrois,
      required int nbrSuit,
      required double prixChambreIndiv,
      required double prixChambreDeux,
      required double prixChambreTrois,
      required double prixSuit,
      required String description,
      required String photoCoverture,
      required double latitude,
      required double longitude,
      required DateTime dateDebut,
      required DateTime dateFin});
}

abstract class EditHebergmentViewModelOutput {
  Stream<Hebergment> get outputheberg;
  Stream<List<String>> get outputPhoto;

  Stream<bool> get outputIsHebergmentUpdated;
}
