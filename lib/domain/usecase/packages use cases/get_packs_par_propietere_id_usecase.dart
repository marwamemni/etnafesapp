import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../model/models.dart';
import '../../repository/repository.dart';
import '../base_usecase.dart';

class GetPacksParProrietereIdUseCase
    implements BaseUseCase<String, List<Pack>> {
  final Repository _repository;

  GetPacksParProrietereIdUseCase(this._repository);

  @override
  Future<Either<Failure, List<Pack>>> execute(String input) async {
    return await _repository.getPacksParProprietaireId(input);
  }
}
