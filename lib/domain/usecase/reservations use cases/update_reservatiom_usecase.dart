import 'package:agence_voyage/data/network/failure.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../repository/repository.dart';

class UpdateReservationUseCase
    implements BaseUseCase<UpdateReservationRequest, Reservation> {
  final Repository _repository;

  UpdateReservationUseCase(this._repository);

  @override
  Future<Either<Failure, Reservation>> execute(
      UpdateReservationRequest input) async {
    return await _repository.updateReservation(input);
  }
}
