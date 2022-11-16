import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';

class GetRestaurantUseCase implements BaseUseCase<String, Restaurant> {
  final Repository _repository;

  GetRestaurantUseCase(this._repository);

  @override
  Future<Either<Failure, Restaurant>> execute(String input) async {
    return await _repository.getRestaurant(input);
  }
}
