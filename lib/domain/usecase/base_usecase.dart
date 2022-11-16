import 'package:agence_voyage/data/network/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
  // Future<Either<Failure, Out>> executeGet(String id);
  // Future<Either<Failure, Out>> executeUpdate(In input);
  // Future<Either<Failure, bool>> executeDelete(String id);
  // Future<Either<Failure, List<Out>>> executeGetListForUser(Filtre filtre);
  // Future<Either<Failure, List<Out>>> executeGetListForProprietere(
  //     Filtre filtre);
}
