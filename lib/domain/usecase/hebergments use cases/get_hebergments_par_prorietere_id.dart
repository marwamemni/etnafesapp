import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../base_usecase.dart';

class GethebergmentsParProprietaireUseCase
    implements BaseUseCase<String, List<Hebergment>> {
  final Repository _repository;

  GethebergmentsParProprietaireUseCase(this._repository);

  @override
  Future<Either<Failure, List<Hebergment>>> execute(String input) async {
    return await _repository.getHebergmentsParProprietaireId(input);
  }
}
