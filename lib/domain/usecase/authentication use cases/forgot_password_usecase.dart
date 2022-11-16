import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, bool> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(String input) async {
    return await _repository.forgotPassword(input);
  }
}
