import 'package:agence_voyage/data/network/failure.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/repository/repository.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:agence_voyage/presentation/common/freezed_data_classes.dart';
import 'package:dartz/dartz.dart';

import '../../repository/repository.dart';

class GetUserUseCase implements BaseUseCase<String, Authentication> {
  final Repository _repository;

  GetUserUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(String input) async {
    return await _repository.getUser(id: input);
  }
}
