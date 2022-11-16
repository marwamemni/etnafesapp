import 'package:agence_voyage/data/network/failure.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/repository/repository.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../repository/repository.dart';

class LogoutUseCase implements BaseUseCase<void, Authentication> {
  final Repository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(void input) async {
    return await _repository.logout();
  }
}
