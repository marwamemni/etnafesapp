import 'package:agence_voyage/data/network/failure.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/repository/repository.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../repository/repository.dart';

class UpdateProfilUseCase
    implements BaseUseCase<UpdateProfilReques, Authentication> {
  final Repository _repository;

  UpdateProfilUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(UpdateProfilReques input,
      {String? id}) async {
    return await _repository.updateProfil(input, id: id);
  }
}
