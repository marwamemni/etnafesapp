import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../base_usecase.dart';

class GetPackUseCase implements BaseUseCase<String, Pack> {
  final Repository _repository;

  GetPackUseCase(this._repository);

  @override
  Future<Either<Failure, Pack>> execute(String input) async {
    return await _repository.getPack(input);
  }
}
