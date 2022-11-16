// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/images%20use%20cases/delete_image_usecase.dart';
import 'package:agence_voyage/domain/usecase/images%20use%20cases/store_image_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/usecase/packages use cases/get_pack_usecase.dart';
import '../../../domain/usecase/packages use cases/update_pack_usecase.dart';

class EditPackViewModel extends BaseViewModel
    with EditPackViewModelInput, EditPackViewModelOutput {
  final StreamController _packStreamController =
      StreamController<Pack>.broadcast();
  final StreamController _photoStreamController =
      StreamController<String>.broadcast();
  final StreamController _isPackPostedStreamController =
      StreamController<bool>.broadcast();
  final StreamController _addActivityStreamController =
      StreamController<List<String>>.broadcast();

  final UpDatePackUseCase _upDatePackUseCase = instance<UpDatePackUseCase>();
  final GetPackUseCase _getPackUseCase = instance<GetPackUseCase>();
  final StoreImageUseCase _storeImageUseCase = instance<StoreImageUseCase>();
  final DeleteImageUseCase _deleteImageUseCase = instance<DeleteImageUseCase>();

  Pack? _pack;
  List<String> _photos = [];
  List<String> _activites = [];

  @override
  void start() {}

  @override
  void dispose() {
    _packStreamController.close();
    _isPackPostedStreamController.close();
    _photoStreamController.close();
    _addActivityStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inpuIsHebergmentPosted => _isPackPostedStreamController.sink;

  @override
  Sink get inputPhotos => _photoStreamController.sink;

  @override
  Sink get inputActivites => _addActivityStreamController.sink;

  @override
  Sink get inputPack => _packStreamController.sink;

  @override
  getPack(String id) async {
    (await _getPackUseCase.execute(id)).fold((l) {}, (r) {
      inputPack.add(r);
      _photos = r.photos;
    });
    await Future.delayed(const Duration(seconds: 1));
    inputPhotos.add('');
  }

  @override
  updatePack(
      {required String name,
      required int nbrVoyager,
      required double prix,
      required String description,
      required String photoCoverture,
      required DateTime dateDebut,
      required DateTime dateFin}) async {
    _photos.remove('');
    (await _upDatePackUseCase.execute(UpDatePackRequest(
      id: _pack!.id,
      name: name,
      nbrPlaceDisp: nbrVoyager,
      description: description,
      photoCoverture: photoCoverture,
      activites: _activites,
      nbrPlace: nbrVoyager,
      prix: prix,
      photos: _photos,
      dateDebut: dateDebut,
      dateFin: dateFin,
    )))
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
  removePhoto(String photo) async {
    _photos.remove(photo);
    inputPhotos.add('');
    await _deleteImageUseCase.execute(photo);
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
  Stream<bool> get outputIsHebergmentPosted =>
      _isPackPostedStreamController.stream.map((event) => event);

  @override
  Stream<List<String>> get outputPhoto =>
      _photoStreamController.stream.map((event) {
        if (event != null && event != '') {
          _photos.add(event);
        }
        return _photos;
      });

  @override
  Stream<List<String>> get outputActivites =>
      _addActivityStreamController.stream.map((_) {
        return _activites;
      });

  @override
  Stream<Pack> get outputPack => _packStreamController.stream.map((pack) {
        if (pack != null) {
          _pack = pack;
        }
        return _pack!;
      });
}

abstract class EditPackViewModelInput {
  Sink get inputPack;
  getPack(String id);

  addPhoto(XFile photo);
  removePhoto(String photo);
  Sink get inputPhotos;

  addActivity(String activity);
  removeActivity(String activity);
  Sink get inputActivites;

  Sink get inpuIsHebergmentPosted;
  updatePack(
      {required String name,
      required int nbrVoyager,
      required double prix,
      required String description,
      required String photoCoverture,
      required DateTime dateDebut,
      required DateTime dateFin});
}

abstract class EditPackViewModelOutput {
  Stream<Pack> get outputPack;

  Stream<List<String>> get outputPhoto;

  Stream<List<String>> get outputActivites;

  Stream<bool> get outputIsHebergmentPosted;
}
