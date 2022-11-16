import 'package:agence_voyage/data/network/failure.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/repository/repository.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:agence_voyage/presentation/common/freezed_data_classes.dart';
import 'package:dartz/dartz.dart';

import '../../repository/repository.dart';

class LoginUseCase implements BaseUseCase<LoginObject, Authentication> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginObject input) async {
    return await _repository
        .login(LoginRequest(input.userName, input.password));
  }
}
