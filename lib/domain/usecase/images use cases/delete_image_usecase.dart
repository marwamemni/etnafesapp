import 'package:agence_voyage/data/network/failure.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../repository/repository.dart';

class DeleteImageUseCase implements BaseUseCase<String, bool> {
  final Repository _repository;

  DeleteImageUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(String input) async {
    return await _repository.deleteImage(input);
  }
}
