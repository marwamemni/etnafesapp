import 'package:agence_voyage/data/network/failure.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../repository/repository.dart';

class GetPaysUseCase implements BaseUseCase<void, List<Paye>> {
  final Repository _repository;

  GetPaysUseCase(this._repository);

  @override
  Future<Either<Failure, List<Paye>>> execute(void input) async {
    return await _repository.getPays();
  }
}
