// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/images%20use%20cases/store_image_usecase.dart';
import 'package:agence_voyage/domain/usecase/packages%20use%20cases/post_pack_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_pays_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_villes_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';
import 'package:image_picker/image_picker.dart';

class AddPackViewModel extends BaseViewModel
    with AddPackViewModelInput, AddPackViewModelOutput {
  final StreamController _paysStreamController =
      StreamController<List<Paye>>.broadcast();
  final StreamController _villesStreamController =
      StreamController<List<Ville>>.broadcast();
  final StreamController _dropDownValueChangeStreamController =
      StreamController<void>.broadcast();
  final StreamController _hebOrResChangedStreamController =
      StreamController<void>.broadcast();
  final StreamController _photoStreamController =
      StreamController<String>.broadcast();
  final StreamController _isPackPostedStreamController =
      StreamController<bool>.broadcast();
  final StreamController _isActiviteOpenStreamController =
      StreamController<bool>.broadcast();
  final StreamController _addActivityStreamController =
      StreamController<List<String>>.broadcast();

  final PostPackUseCase _postPackUseCase = instance<PostPackUseCase>();
  final GetPaysUseCase _getPaysUseCase = instance<GetPaysUseCase>();
  final GetVillesUseCase _getVillesUseCase = instance<GetVillesUseCase>();
  final StoreImageUseCase _storeImageUseCase = instance<StoreImageUseCase>();

  List<Paye>? _pays;
  List<Ville>? _villes;
  List<String> _photos = [];
  List<String> _activites = [];

  @override
  void start() async {
    (await _getPaysUseCase.execute(null)).fold((l) {}, (r) {
      inputPays.add(r);
    });
  }

  @override
  void dispose() {
    _dropDownValueChangeStreamController.close();
    _isPackPostedStreamController.close();
    _paysStreamController.close();
    _photoStreamController.close();
    _villesStreamController.close();
    _isActiviteOpenStreamController.close();
    _addActivityStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inpuIsHebergmentPosted => _isPackPostedStreamController.sink;

  @override
  Sink get inputDropDownValueChange =>
      _dropDownValueChangeStreamController.sink;

  @override
  Sink get inputPays => _paysStreamController.sink;

  @override
  Sink get inputPhotos => _photoStreamController.sink;

  @override
  Sink get inputVilleId => _villesStreamController.sink;

  @override
  Sink get inputIsActiviteOpen => _isActiviteOpenStreamController.sink;

  @override
  Sink get inputActivites => _addActivityStreamController.sink;

  @override
  Sink get inputHebOrResChanged => _hebOrResChangedStreamController.sink;
  @override
  setPaye(String paye) async {
    (await _getVillesUseCase.execute(paye)).fold((l) {}, (r) {
      inputVilleId.add(r);
    });
  }

  @override
  postPack(
      {required String name,
      required List<String> villeId,
      required List<String> hebergments,
      required List<String> restaurants,
      required int nbrVoyager,
      required double prix,
      required String description,
      required String photoCoverture,
      required DateTime dateDebut,
      required DateTime dateFin}) async {
    _photos.remove('');
    (await _postPackUseCase.execute(PostPackRequest(
            name: name,
            villesId: villeId,
            nbrPlaceDisp: nbrVoyager,
            description: description,
            photoCoverture: photoCoverture,
            activites: _activites,
            hebergments: hebergments,
            nbrPlace: nbrVoyager,
            prix: prix,
            restaurants: restaurants,
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

  @override
  addActivity(String activity) {
    _activites.add(activity);
    inputActivites.add(_activites);
  }

  @override
  removeActivity(String activity) {
    _activites.remove(activity);
    inputActivites.add(_activites);
  }
  //outputs

  @override
  Stream<void> get outputDropDownValueChange =>
      _dropDownValueChangeStreamController.stream.map((event) => event);

  @override
  Stream<bool> get outputIsHebergmentPosted =>
      _isPackPostedStreamController.stream.map((event) => event);

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
  Stream<List<Ville>> get outputvilles =>
      _villesStreamController.stream.map((event) {
        if (event != null) {
          _villes = event;
        }
        return _villes!;
      });

  @override
  Stream<bool> get outputIsActiviteOpen =>
      _isActiviteOpenStreamController.stream.map((event) => event);

  @override
  Stream<List<String>> get outputActivites =>
      _addActivityStreamController.stream.map((_) {
        return _activites;
      });

  @override
  Stream<void> get outputHebOrResChanged =>
      _hebOrResChangedStreamController.stream.map((event) => event);
}

abstract class AddPackViewModelInput {
  Sink get inputDropDownValueChange;
  Sink get inputPays;
  Sink get inputVilleId;
  setPaye(String paye);

  addPhoto(XFile photo);
  Sink get inputPhotos;

  addActivity(String activity);
  removeActivity(String activity);
  Sink get inputActivites;

  Sink get inputHebOrResChanged;
  Sink get inputIsActiviteOpen;

  Sink get inpuIsHebergmentPosted;
  postPack(
      {required String name,
      required List<String> villeId,
      required List<String> hebergments,
      required List<String> restaurants,
      required int nbrVoyager,
      required double prix,
      required String description,
      required String photoCoverture,
      required DateTime dateDebut,
      required DateTime dateFin});
}

abstract class AddPackViewModelOutput {
  Stream<List<Paye>> get outputPays;
  Stream<List<Ville>> get outputvilles;
  Stream<void> get outputDropDownValueChange;

  Stream<List<String>> get outputPhoto;

  Stream<bool> get outputIsHebergmentPosted;
  Stream<bool> get outputIsActiviteOpen;
  Stream<List<String>> get outputActivites;
  Stream<void> get outputHebOrResChanged;
}
