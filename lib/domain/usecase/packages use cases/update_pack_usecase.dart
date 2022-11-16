import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../base_usecase.dart';

class UpDatePackUseCase implements BaseUseCase<UpDatePackRequest, Pack> {
  final Repository _repository;

  UpDatePackUseCase(this._repository);

  @override
  Future<Either<Failure, Pack>> execute(UpDatePackRequest input) async {
    return await _repository.upDatePack(input);
  }
}
