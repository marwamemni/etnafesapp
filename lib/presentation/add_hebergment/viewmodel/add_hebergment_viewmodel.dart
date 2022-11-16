import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/hebergments%20use%20cases/post_hebergment_usecase.dart';
import 'package:agence_voyage/domain/usecase/images%20use%20cases/store_image_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_pays_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_villes_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';
import 'package:image_picker/image_picker.dart';

class AddHebergmentViewModel extends BaseViewModel
    with AddHebergmentViewModelInput, AddHebergmentViewModelOutput {
  final StreamController _paysStreamController =
      StreamController<List<Paye>>.broadcast();
  final StreamController _villesStreamController =
      StreamController<List<Ville>>.broadcast();
  final StreamController _typesStreamController =
      StreamController<List<String>>.broadcast();
  final StreamController _dropDownValueChangeStreamController =
      StreamController<void>.broadcast();
  final StreamController _photoStreamController =
      StreamController<String>.broadcast();
  final StreamController _isHebergmentPostedStreamController =
      StreamController<bool>.broadcast();

  final PosthebergmentUseCase _posthebergmentUseCase =
      instance<PosthebergmentUseCase>();
  final GetPaysUseCase _getPaysUseCase = instance<GetPaysUseCase>();
  final GetVillesUseCase _getVillesUseCase = instance<GetVillesUseCase>();
  final StoreImageUseCase _storeImageUseCase = instance<StoreImageUseCase>();

  List<Paye>? _pays;
  List<Ville>? _villes;
  final List<String> _types = ['Hotel', 'Motel'];
  // ignore: prefer_final_fields
  List<String> _photos = [];

  @override
  void start() async {
    (await _getPaysUseCase.execute(null)).fold((l) {}, (r) {
      inputPays.add(r);
    });
    inputType.add(_types);
  }

  @override
  void dispose() {
    _dropDownValueChangeStreamController.close();
    _isHebergmentPostedStreamController.close();
    _paysStreamController.close();
    _photoStreamController.close();
    _typesStreamController.close();
    _villesStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inpuIsHebergmentPosted => _isHebergmentPostedStreamController.sink;

  @override
  Sink get inputDropDownValueChange =>
      _dropDownValueChangeStreamController.sink;

  @override
  Sink get inputPays => _paysStreamController.sink;

  @override
  Sink get inputPhotos => _photoStreamController.sink;

  @override
  Sink get inputType => _typesStreamController.sink;

  @override
  Sink get inputVilleId => _villesStreamController.sink;

  @override
  setPaye(String paye) async {
    (await _getVillesUseCase.execute(paye)).fold((l) {}, (r) {
      inputVilleId.add(r);
    });
  }

  @override
  postHebergment(
      {required String name,
      required String villeId,
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
      required String categorie,
      required String description,
      required String photoCoverture,
      required double latitude,
      required double longitude,
      required DateTime dateDebut,
      required DateTime dateFin}) async {
    _photos.remove('');
    (await _posthebergmentUseCase.execute(PosthebergmentRequest(
            name: name,
            villeId: villeId,
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
            prixSuits: prixSuit,
            categorie: categorie,
            description: description,
            photoCoverture: photoCoverture,
            latitude: latitude,
            longitude: longitude,
            photos: _photos,
            dateDebut: dateDebut,
            dateFin: dateFin,
            proprietaireId: user.id)))
        .fold((l) {}, (r) {
      inpuIsHebergmentPosted.add(true);
    });
  }

  @override
  addPhoto(XFile photo) async {
    (await _storeImageUseCase.execute(photo)).fold((l) {}, (r) {
      inputPhotos.add(r);
    });
  }

  //outputs

  @override
  Stream<void> get outputDropDownValueChange =>
      _dropDownValueChangeStreamController.stream.map((event) => event);

  @override
  Stream<bool> get outputIsHebergmentPosted =>
      _isHebergmentPostedStreamController.stream.map((event) => event);

  @override
  Stream<List<Paye>> get outputPays =>
      _paysStreamController.stream.map((event) {
        if (event != null) {
          _pays = event;
        }
        return _pays!;
      });

  @override
  Stream<List<String>> get outputPhoto =>
      _photoStreamController.stream.map((event) {
        if (event != null && event != '') {
          _photos.add(event);
        }
        return _photos;
      });

  @override
  Stream<List<String>> get outputTypes =>
      _typesStreamController.stream.map((_) {
        return _types;
      });

  @override
  Stream<List<Ville>> get outputvilles =>
      _villesStreamController.stream.map((event) {
        if (event != null) {
          _villes = event;
        }
        return _villes!;
      });
}

abstract class AddHebergmentViewModelInput {
  Sink get inputDropDownValueChange;
  Sink get inputPays;
  Sink get inputVilleId;
  Sink get inputType;
  setPaye(String paye);

  addPhoto(XFile photo);
  Sink get inputPhotos;

  Sink get inpuIsHebergmentPosted;
  postHebergment(
      {required String name,
      required String villeId,
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
      required String categorie,
      required String description,
      required String photoCoverture,
      required double latitude,
      required double longitude,
      required DateTime dateDebut,
      required DateTime dateFin});
}

abstract class AddHebergmentViewModelOutput {
  Stream<List<Paye>> get outputPays;
  Stream<List<Ville>> get outputvilles;
  Stream<List<String>> get outputTypes;
  Stream<void> get outputDropDownValueChange;

  Stream<List<String>> get outputPhoto;

  Stream<bool> get outputIsHebergmentPosted;
}
