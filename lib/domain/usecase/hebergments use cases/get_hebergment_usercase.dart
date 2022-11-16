import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../repository/repository.dart';
import '../base_usecase.dart';

class GethebergmentUseCase implements BaseUseCase<String, Hebergment> {
  final Repository _repository;

  GethebergmentUseCase(this._repository);

  @override
  Future<Either<Failure, Hebergment>> execute(String input) async {
    return await _repository.getHebergment(input);
  }
}
