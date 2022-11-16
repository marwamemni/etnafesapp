import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../base_usecase.dart';

class GethebergmentsParParametreUseCase
    implements
        BaseUseCase<GethebergmentsParParametreRequest, List<Hebergment>> {
  final Repository _repository;

  GethebergmentsParParametreUseCase(this._repository);

  @override
  Future<Either<Failure, List<Hebergment>>> execute(
      GethebergmentsParParametreRequest input) async {
    return await _repository.gethebergmentsParParametre(input);
  }
}
