import 'dart:async';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/images%20use%20cases/delete_image_usecase.dart';
import 'package:agence_voyage/domain/usecase/images%20use%20cases/store_image_usecase.dart';
import 'package:agence_voyage/domain/usecase/restaurants%20use%20cases/get_restaurant_usecase.dart';
import 'package:agence_voyage/domain/usecase/restaurants%20use%20cases/update_restaurant_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_pays_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_villes_usecase.dart';
import 'package:agence_voyage/presentation/base/baseviewmodel.dart';
import 'package:image_picker/image_picker.dart';

class EditRestaurantViewModel extends BaseViewModel
    with EditRestaurantViewModelInput, EditRestaurantViewModelOutput {
  final StreamController _restaurantStreamController =
      StreamController<Restaurant>.broadcast();
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

  final GetRestaurantUseCase _getRestaurantUseCase =
      instance<GetRestaurantUseCase>();
  final UpdateRestaurantUseCase _updateRestaurantUseCase =
      instance<UpdateRestaurantUseCase>();
  final GetPaysUseCase _getPaysUseCase = instance<GetPaysUseCase>();
  final GetVillesUseCase _getVillesUseCase = instance<GetVillesUseCase>();
  final StoreImageUseCase _storeImageUseCase = instance<StoreImageUseCase>();
  final DeleteImageUseCase _deleteImageUseCase = instance<DeleteImageUseCase>();

  List<Paye>? _pays;
  List<Ville>? _villes;
  Restaurant? _restaurant;
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
    _restaurantStreamController.close();
    _dropDownValueChangeStreamController.close();
    _isRestaurantPostedStreamController.close();
    _paysStreamController.close();
    _photoStreamController.close();
    _villesStreamController.close();
    super.dispose();
  }

  //inputs

  @override
  Sink get inputRestaurant => _restaurantStreamController.sink;

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
  getRestaurant(String id) async {
    (await _getRestaurantUseCase.execute(id)).fold((l) {}, (r) {
      inputRestaurant.add(r);
      _photos = r.photos;
      inputPhotos.add('');
    });
  }

  @override
  setPaye(String paye) async {
    (await _getVillesUseCase.execute(paye)).fold((l) {}, (r) {
      inputVilleId.add(r);
    });
  }

  @override
  updateRestaurant({
    required String name,
    required String description,
    required String photoCoverture,
    required double latitude,
    required double longitude,
  }) async {
    _photos.remove('');
    (await _updateRestaurantUseCase.execute(UpdateRestaurantRequest(
      id: _restaurant!.id,
      name: name,
      description: description,
      photoCoverture: photoCoverture,
      latitude: latitude,
      longitude: longitude,
      photos: _photos,
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

  //outputs

  @override
  Stream<Restaurant> get outputRestaurant =>
      _restaurantStreamController.stream.map((restaurant) {
        if (restaurant != null) {
          _restaurant = restaurant;
        }
        return _restaurant!;
      });

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

abstract class EditRestaurantViewModelInput {
  getRestaurant(String id);
  Sink get inputRestaurant;

  Sink get inputDropDownValueChange;
  Sink get inputPays;
  Sink get inputVilleId;
  setPaye(String paye);

  addPhoto(XFile photo);
  removePhoto(String photo);
  Sink get inputPhotos;

  Sink get inpuIsHebergmentPosted;
  updateRestaurant({
    required String name,
    required String description,
    required String photoCoverture,
    required double latitude,
    required double longitude,
  });
}

abstract class EditRestaurantViewModelOutput {
  Stream<Restaurant> get outputRestaurant;

  Stream<List<Paye>> get outputPays;
  Stream<List<Ville>> get outputvilles;
  Stream<void> get outputDropDownValueChange;

  Stream<List<String>> get outputPhoto;

  Stream<bool> get outputIsHebergmentPosted;
}
