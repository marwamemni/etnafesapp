import 'package:agence_voyage/data/network/failure.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../repository/repository.dart';

class PostReservatonUseCase
    implements BaseUseCase<PostReservationRequest, Reservation> {
  final Repository _repository;

  PostReservatonUseCase(this._repository);

  @override
  Future<Either<Failure, Reservation>> execute(
      PostReservationRequest input) async {
    return await _repository.postReservation(input);
  }
}
