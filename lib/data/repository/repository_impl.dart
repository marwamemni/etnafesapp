import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/data_source/remote_data_source.dart';
import 'package:agence_voyage/data/mapper/mapper.dart';
import 'package:agence_voyage/data/network/error_handler.dart';
import 'package:agence_voyage/data/network/failure.dart';
import 'package:agence_voyage/data/network/network_info.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/app_prefs.dart';
import '../../domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource = instance<RemoteDataSource>();
  final NetworkInfo _networkInfo = instance<NetworkInfo>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  RepositoryImpl();
// failure = left
// right = bool(type)
  @override
  Future<Either<Failure, bool>> deleteHebergment(String id) async {
    return await _doLocalFunAndRemoteFun<bool>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.deleteHebergment(id);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, bool>> deleteImage(String imageUrl) async {
    // deleteImage
    return await _doLocalFunAndRemoteFun<bool>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.deleteImage(imageUrl);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, bool>> deletePack(String id) async {
    // deletePack
    return await _doLocalFunAndRemoteFun<bool>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.deletePack(id);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, bool>> deleteReservation(String id) async {
    // deleteReservation
    return await _doLocalFunAndRemoteFun<bool>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.deleteReservation(id);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, bool>> deleteRestaurant(String id) async {
    // deleteRestaurant
    return await _doLocalFunAndRemoteFun<bool>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.deleteRestaurant(id);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, bool>> forgotPassword(String email) async {
    // forgotPassword
    return await _doLocalFunAndRemoteFun<bool>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.forgotPassword(email);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Hebergment>> getHebergment(String id) async {
    // getHebergment
    return await _doLocalFunAndRemoteFun<Hebergment>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.getHebergment(id);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Pack>> getPack(String id) async {
    // getPack
    return await _doLocalFunAndRemoteFun<Pack>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.getPack(id);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, List<Pack>>> getPacksParParametre(
      GetPacksParParametreRequest getPacksParParametreRequest) async {
    // getPacksParParametre
    return await _doLocalFunAndRemoteFun<List<Pack>>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource
              .getPacksParParametre(getPacksParParametreRequest);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, List<Paye>>> getPays() async {
    // getPays
    return await _doLocalFunAndRemoteFun<List<Paye>>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.getPays();
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Reservation>> getReservation(String id) async {
    // getReservation
    return await _doLocalFunAndRemoteFun<Reservation>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.getReservation(id);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, List<Reservation>>> getReservationParParametre(
      GetReservationParParametreRequest
          getReservationParParametreRequest) async {
    // getReservationParParametre
    return await _doLocalFunAndRemoteFun<List<Reservation>>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource
              .getReservationParParametre(getReservationParParametreRequest);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Restaurant>> getRestaurant(String id) async {
    // getRestaurant
    return await _doLocalFunAndRemoteFun<Restaurant>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.getRestaurant(id);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurantsParProprietaireId(
      String proprietaireId) async {
    // getRestaurantsParProprietaireId
    return await _doLocalFunAndRemoteFun<List<Restaurant>>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource
              .getRestaurantsParProprietaireId(proprietaireId);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, List<Restaurant>>> getRestaurantsParVille(
      String ville) async {
    // getRestaurantsParVille
    return await _doLocalFunAndRemoteFun<List<Restaurant>>(
        localFun: null,
        remoteFun: () async {
          final response =
              await _remoteDataSource.getRestaurantsParVille(ville);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Authentication>> getUser({String? id}) async {
    // getUser
    return await _doLocalFunAndRemoteFun<Authentication>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.getUser(id: id);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, List<Ville>>> getVillesParPaye(String payeId) async {
    // getVillesParPaye
    return await _doLocalFunAndRemoteFun<List<Ville>>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.getVillesParPaye(payeId);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, List<Hebergment>>> gethebergmentsParParametre(
      GethebergmentsParParametreRequest
          gethebergmentsParParametreRequest) async {
    // gethebergmentsParParametre
    return await _doLocalFunAndRemoteFun<List<Hebergment>>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource
              .gethebergmentsParParametre(gethebergmentsParParametreRequest);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    // login
    return await _doLocalFunAndRemoteFun<Authentication>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.login(loginRequest);
          if (response.status == ResponseCode.SUCCESS) {
            if (response.id != null) {
              await _appPreferences.setUserLoggedIn(response.id!);
            }
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Authentication>> logout() async {
    // logout
    return await _doLocalFunAndRemoteFun<Authentication>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.logout();
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Pack>> postPack(
      PostPackRequest postPackRequest) async {
    // postPack
    return await _doLocalFunAndRemoteFun<Pack>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.postPack(postPackRequest);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Reservation>> postReservation(
      PostReservationRequest postReservationRequest) async {
    // postReservation
    return await _doLocalFunAndRemoteFun<Reservation>(
        localFun: null,
        remoteFun: () async {
          final response =
              await _remoteDataSource.postReservation(postReservationRequest);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Restaurant>> postRestaurant(
      PostRestaurantRequest postRestaurantRequest) async {
    // postRestaurant
    return await _doLocalFunAndRemoteFun<Restaurant>(
        localFun: null,
        remoteFun: () async {
          final response =
              await _remoteDataSource.postRestaurant(postRestaurantRequest);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Hebergment>> posthebergment(
      PosthebergmentRequest posthebergmentRequest) async {
    // posthebergment
    return await _doLocalFunAndRemoteFun<Hebergment>(
        localFun: null,
        remoteFun: () async {
          final response =
              await _remoteDataSource.posthebergment(posthebergmentRequest);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    // register
    return await _doLocalFunAndRemoteFun<Authentication>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.register(registerRequest);
          if (response.status == ResponseCode.SUCCESS) {
            if (response.id != null) {
              await _appPreferences.setUserLoggedIn(response.id!);
            }
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, String>> storeImage(XFile imageFile) async {
    // storeImage
    return await _doLocalFunAndRemoteFun<String>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource.storeImage(imageFile);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Pack>> upDatePack(
      UpDatePackRequest upDatePackRequest) async {
    // upDatePack
    return await _doLocalFunAndRemoteFun<Pack>(
        localFun: null,
        remoteFun: () async {
          final response =
              await _remoteDataSource.upDatePack(upDatePackRequest);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Authentication>> updateProfil(
      UpdateProfilReques updateProfilReques,
      {String? id}) async {
    // updateProfil
    return await _doLocalFunAndRemoteFun<Authentication>(
        localFun: null,
        remoteFun: () async {
          final response =
              await _remoteDataSource.updateProfil(updateProfilReques, id: id);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Reservation>> updateReservation(
      UpdateReservationRequest updateReservationRequest) async {
    // updateReservation
    return await _doLocalFunAndRemoteFun<Reservation>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource
              .updateReservation(updateReservationRequest);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Restaurant>> updateRestaurant(
      UpdateRestaurantRequest updateRestaurantRequest) async {
    // updateRestaurant
    return await _doLocalFunAndRemoteFun<Restaurant>(
        localFun: null,
        remoteFun: () async {
          final response =
              await _remoteDataSource.updateRestaurant(updateRestaurantRequest);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, Hebergment>> updatehebergment(
      UpdatehebergmentRequest updatehebergmentRequest) async {
    // updatehebergment
    return await _doLocalFunAndRemoteFun<Hebergment>(
        localFun: null,
        remoteFun: () async {
          final response =
              await _remoteDataSource.updatehebergment(updatehebergmentRequest);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, List<Hebergment>>> getHebergmentsParProprietaireId(
      String proprietaireId) async {
    return await _doLocalFunAndRemoteFun<List<Hebergment>>(
        localFun: null,
        remoteFun: () async {
          final response = await _remoteDataSource
              .getHebergmentsParProprietaireId(proprietaireId);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  @override
  Future<Either<Failure, List<Pack>>> getPacksParProprietaireId(
      String proprietaireId) async {
    return await _doLocalFunAndRemoteFun<List<Pack>>(
        localFun: null,
        remoteFun: () async {
          final response =
              await _remoteDataSource.getPacksParProprietaireId(proprietaireId);
          if (response.status == ResponseCode.SUCCESS) {
            return Right(response.toDomain());
          } else {
            throw getFailure(response.status);
          }
        });
  }

  //private functions
  Future<Either<Failure, Obj>> _checkInternetConnection<Obj>(
      Future<Either<Failure, Obj>> Function() function) async {
    if (await _networkInfo.isConnected) {
      return await function();
    } else {
      return Left(getFailure(ResponseCode.NO_INTERNET));
    }
  }

  Future<Either<Failure, Obj>> _doLocalFunAndRemoteFun<Obj>(
      {Future<Either<Failure, Obj>> Function()? localFun,
      Future<Either<Failure, Obj>> Function()? remoteFun}) async {
    if (localFun == null && remoteFun == null) {
      return Left(getFailure(ResponseCode.INTERNAL_FAILURE));
    } else {
      try {
        if (localFun != null) {
          return await localFun();
        } else {
          throw Error();
        }
      } catch (_) {
        if (remoteFun != null) {
          return _checkInternetConnection(() async {
            try {
              return await remoteFun();
            } catch (error) {
              // print((error as Failure).message);
              return Left(getFailure(ResponseCode.SERVER_FAILURE));
            }
          });
        } else {
          return Left(getFailure(ResponseCode.INTERNAL_FAILURE));
        }
      }
    }
  }
}
