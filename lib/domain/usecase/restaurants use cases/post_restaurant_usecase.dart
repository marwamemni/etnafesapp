import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';

class PostRestaurantUseCase
    implements BaseUseCase<PostRestaurantRequest, Restaurant> {
  final Repository _repository;

  PostRestaurantUseCase(this._repository);

  @override
  Future<Either<Failure, Restaurant>> execute(
      PostRestaurantRequest input) async {
    return await _repository.postRestaurant(input);
  }
}
