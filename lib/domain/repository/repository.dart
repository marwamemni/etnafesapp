import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../model/models.dart';

abstract class Repository {
  //Authentication services
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);

  Future<Either<Failure, bool>> forgotPassword(String email);

  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);

  Future<Either<Failure, Authentication>> logout();

  Future<Either<Failure, Authentication>> updateProfil(
      UpdateProfilReques updateProfilReques,
      {String? id});

  Future<Either<Failure, Authentication>> getUser({String? id});

  //Ville services
  Future<Either<Failure, List<Paye>>> getPays();

  Future<Either<Failure, List<Ville>>> getVillesParPaye(String payeId);

  //Restaurant services
  Future<Either<Failure, Restaurant>> postRestaurant(
      PostRestaurantRequest postRestaurantRequest);

  Future<Either<Failure, Restaurant>> updateRestaurant(
      UpdateRestaurantRequest updateRestaurantRequest);

  Future<Either<Failure, Restaurant>> getRestaurant(String id);

  Future<Either<Failure, List<Restaurant>>> getRestaurantsParVille(
      String ville);

  Future<Either<Failure, List<Restaurant>>> getRestaurantsParProprietaireId(
      String proprietaireId);

  Future<Either<Failure, bool>> deleteRestaurant(String id);

  //hebergment services
  Future<Either<Failure, Hebergment>> posthebergment(
      PosthebergmentRequest posthebergmentRequest);

  Future<Either<Failure, Hebergment>> updatehebergment(
      UpdatehebergmentRequest updatehebergmentRequest);

  Future<Either<Failure, Hebergment>> getHebergment(String id);

  Future<Either<Failure, bool>> deleteHebergment(String id);

  Future<Either<Failure, List<Hebergment>>> gethebergmentsParParametre(
      GethebergmentsParParametreRequest gethebergmentsParParametreRequest);

  Future<Either<Failure, List<Hebergment>>> getHebergmentsParProprietaireId(
      String proprietaireId);

  //Pack services
  Future<Either<Failure, Pack>> postPack(PostPackRequest postPackRequest);

  Future<Either<Failure, Pack>> upDatePack(UpDatePackRequest upDatePackRequest);

  Future<Either<Failure, Pack>> getPack(String id);

  Future<Either<Failure, bool>> deletePack(String id);

  Future<Either<Failure, List<Pack>>> getPacksParParametre(
      GetPacksParParametreRequest getPacksParParametreRequest);

  Future<Either<Failure, List<Pack>>> getPacksParProprietaireId(
      String proprietaireId);

  //Reservation services
  Future<Either<Failure, Reservation>> postReservation(
      PostReservationRequest postReservationRequest);

  Future<Either<Failure, Reservation>> updateReservation(
      UpdateReservationRequest updateReservationRequest);

  Future<Either<Failure, Reservation>> getReservation(String id);

  Future<Either<Failure, bool>> deleteReservation(String id);

  Future<Either<Failure, List<Reservation>>> getReservationParParametre(
      GetReservationParParametreRequest getReservationParParametreRequest);

  //Image services
  Future<Either<Failure, String>> storeImage(XFile imageFile);
  Future<Either<Failure, bool>> deleteImage(String imageUrl);
}
