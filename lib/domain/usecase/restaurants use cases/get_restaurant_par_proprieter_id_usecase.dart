import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';

class GetRestaurantsParProprietereIdUseCase
    implements BaseUseCase<String, List<Restaurant>> {
  final Repository _repository;

  GetRestaurantsParProprietereIdUseCase(this._repository);

  @override
  Future<Either<Failure, List<Restaurant>>> execute(String input) async {
    return await _repository.getRestaurantsParProprietaireId(input);
  }
}
