import 'package:agence_voyage/data/network/failure.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:agence_voyage/presentation/common/freezed_data_classes.dart';
import 'package:dartz/dartz.dart';

import '../../repository/repository.dart';

class RegisterUseCase implements BaseUseCase<RegisterObject, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(RegisterObject input) async {
    return await _repository.register(RegisterRequest(
      email: input.email,
      civilite: input.civilite,
      firstName: input.firstName,
      lastName: input.lastName,
      password: input.password,
      phone: input.phone,
      photo: input.photo,
      points: input.points,
      userType: input.userType,
      villeId: input.villeId,
    ));
  }
}
