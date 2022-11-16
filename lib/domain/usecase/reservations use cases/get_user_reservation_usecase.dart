import 'package:agence_voyage/data/network/failure.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../repository/repository.dart';

class GetUserReservatonUseCase
    implements
        BaseUseCase<GetReservationParParametreRequest, List<Reservation>> {
  final Repository _repository;

  GetUserReservatonUseCase(this._repository);

  @override
  Future<Either<Failure, List<Reservation>>> execute(
      GetReservationParParametreRequest input) async {
    return await _repository.getReservationParParametre(input);
  }
}
