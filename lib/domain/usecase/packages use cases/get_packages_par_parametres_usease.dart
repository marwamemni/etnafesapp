import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../base_usecase.dart';

class GetPacksParParametreUseCase
    implements BaseUseCase<GetPacksParParametreRequest, List<Pack>> {
  final Repository _repository;

  GetPacksParParametreUseCase(this._repository);

  @override
  Future<Either<Failure, List<Pack>>> execute(
      GetPacksParParametreRequest input) async {
    return await _repository.getPacksParParametre(input);
  }
}
