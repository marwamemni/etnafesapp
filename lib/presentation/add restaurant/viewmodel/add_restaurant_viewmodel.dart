import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/images%20use%20cases/store_image_usecase.dart';
import 'package:agence_voyage/domain/usecase/restaurants%20use%20cases/post_restaurant_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_pays_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_villes_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';
import 'package:image_picker/image_picker.dart';

class AddRestaurantViewModel extends BaseViewModel
    with AddRestaurantViewModelInput, AddRestaurantViewModelOutput {
  final StreamController _paysStreamController =
      StreamController<List<Paye>>.broadcast();
  final StreamController _villesStreamController =
      StreamController<List<Ville>>.broadcast();
  final StreamController _dropDownValueChangeStreamController =
      StreamController<void>.broadcast();
  final StreamController _photoStreamController =
      StreamController<String>.broadcast();
  final StreamController _isRestaurantPostedStreamController =
      StreamController<bool>.broadcast();

  final PostRestaurantUseCase _postRestaurantUseCase =
      instance<PostRestaurantUseCase>();
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
  }

  @override
  void dispose() {
    _dropDownValueChangeStreamController.close();
    _isRestaurantPostedStreamController.close();
    _paysStreamController.close();
    _photoStreamController.close();
    _villesStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inpuIsHebergmentPosted => _isRestaurantPostedStreamController.sink;

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
  setPaye(String paye) async {
    (await _getVillesUseCase.execute(paye)).fold((l) {}, (r) {
      inputVilleId.add(r);
    });
  }

  @override
  postRestaurant({
    required String name,
    required String villeId,
    required String description,
    required String photoCoverture,
    required double latitude,
    required double longitude,
  }) async {
    _photos.remove('');
    (await _postRestaurantUseCase.execute(PostRestaurantRequest(
            name: name,
            villeId: villeId,
            description: description,
            photoCoverture: photoCoverture,
            latitude: latitude,
            longitude: longitude,
            photos: _photos,
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
      _isRestaurantPostedStreamController.stream.map((event) => event);

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
}

abstract class AddRestaurantViewModelInput {
  Sink get inputDropDownValueChange;
  Sink get inputPays;
  Sink get inputVilleId;
  setPaye(String paye);

  addPhoto(XFile photo);
  Sink get inputPhotos;

  Sink get inpuIsHebergmentPosted;
  postRestaurant({
    required String name,
    required String villeId,
    required String description,
    required String photoCoverture,
    required double latitude,
    required double longitude,
  });
}

abstract class AddRestaurantViewModelOutput {
  Stream<List<Paye>> get outputPays;
  Stream<List<Ville>> get outputvilles;
  Stream<void> get outputDropDownValueChange;

  Stream<List<String>> get outputPhoto;

  Stream<bool> get outputIsHebergmentPosted;
}
