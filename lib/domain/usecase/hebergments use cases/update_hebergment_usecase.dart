import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../base_usecase.dart';

class UpdatehebergmentUseCase
    implements BaseUseCase<UpdatehebergmentRequest, Hebergment> {
  final Repository _repository;

  UpdatehebergmentUseCase(this._repository);

  @override
  Future<Either<Failure, Hebergment>> execute(
      UpdatehebergmentRequest input) async {
    return await _repository.updatehebergment(input);
  }
}
