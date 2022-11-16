import 'package:agence_voyage/data/network/failure.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../repository/repository.dart';

class GetVillesUseCase implements BaseUseCase<String, List<Ville>> {
  final Repository _repository;

  GetVillesUseCase(this._repository);

  @override
  Future<Either<Failure, List<Ville>>> execute(String input) async {
    return await _repository.getVillesParPaye(input);
  }
}
