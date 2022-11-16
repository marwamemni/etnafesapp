import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';

class UpdateRestaurantUseCase
    implements BaseUseCase<UpdateRestaurantRequest, Restaurant> {
  final Repository _repository;

  UpdateRestaurantUseCase(this._repository);

  @override
  Future<Either<Failure, Restaurant>> execute(
      UpdateRestaurantRequest input) async {
    return await _repository.updateRestaurant(input);
  }
}
