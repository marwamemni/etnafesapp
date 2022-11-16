import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/app_api.dart';
import 'package:agence_voyage/data/network/requests.dart';
import 'package:agence_voyage/data/response/responses.dart';
import 'package:image_picker/image_picker.dart';

abstract class RemoteDataSource {
  //Authentication services
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<DefaultResponse> forgotPassword(String email);

  Future<AuthenticationResponse> register(RegisterRequest registerRequest);

  Future<AuthenticationResponse> logout();

  Future<AuthenticationResponse> updateProfil(
      UpdateProfilReques updateProfilReques,
      {String? id});

  Future<AuthenticationResponse> getUser({String? id});

  //Ville services
  Future<PaysResponse> getPays();

  Future<VillesResponse> getVillesParPaye(String payeId);

  //Restaurant services
  Future<RestaurantResponse> postRestaurant(
      PostRestaurantRequest postRestaurantRequest);

  Future<RestaurantResponse> updateRestaurant(
      UpdateRestaurantRequest updateRestaurantRequest);

  Future<RestaurantResponse> getRestaurant(String id);

  Future<RestaurantsResponse> getRestaurantsParVille(String ville);

  Future<RestaurantsResponse> getRestaurantsParProprietaireId(
      String proprietaireId);

  Future<DefaultResponse> deleteRestaurant(String id);

  //hebergment services
  Future<HebergmentResponse> posthebergment(
      PosthebergmentRequest posthebergmentRequest);

  Future<HebergmentResponse> updatehebergment(
      UpdatehebergmentRequest updatehebergmentRequest);

  Future<HebergmentResponse> getHebergment(String id);

  Future<DefaultResponse> deleteHebergment(String id);

  Future<HebergmentsResponse> gethebergmentsParParametre(
      GethebergmentsParParametreRequest gethebergmentsParParametreRequest);

  Future<HebergmentsResponse> getHebergmentsParProprietaireId(
      String proprietaireId);

  //Pack services
  Future<PackResponse> postPack(PostPackRequest postPackRequest);

  Future<PackResponse> upDatePack(UpDatePackRequest upDatePackRequest);

  Future<PackResponse> getPack(String id);

  Future<DefaultResponse> deletePack(String id);

  Future<PacksResponse> getPacksParParametre(
      GetPacksParParametreRequest getPacksParParametreRequest);

  Future<PacksResponse> getPacksParProprietaireId(String proprietaireId);

  //Reservation services
  Future<ReservationResponse> postReservation(
      PostReservationRequest postReservationRequest);

  Future<ReservationResponse> updateReservation(
      UpdateReservationRequest updateReservationRequest);

  Future<ReservationResponse> getReservation(String id);

  Future<DefaultResponse> deleteReservation(String id);

  Future<ReservationsResponse> getReservationParParametre(
      GetReservationParParametreRequest getReservationParParametreRequest);

  //Image services
  Future<ImageResponse> storeImage(XFile imageFile);
  Future<DefaultResponse> deleteImage(String imageUrl);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient = instance<AppServiceClient>();

  @override
  Future<DefaultResponse> deleteHebergment(String id) async {
    return await _appServiceClient.deleteHebergment(id);
  }

  @override
  Future<DefaultResponse> deleteImage(String imageUrl) async {
    return await _appServiceClient.deleteImage(imageUrl);
  }

  @override
  Future<DefaultResponse> deletePack(String id) async {
    return await _appServiceClient.deletePack(id);
  }

  @override
  Future<DefaultResponse> deleteReservation(String id) async {
    return await _appServiceClient.deleteReservation(id);
  }

  @override
  Future<DefaultResponse> deleteRestaurant(String id) async {
    return await _appServiceClient.deleteRestaurant(id);
  }

  @override
  Future<DefaultResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<HebergmentResponse> getHebergment(String id) async {
    return await _appServiceClient.getHebergment(id);
  }

  @override
  Future<PackResponse> getPack(String id) async {
    return await _appServiceClient.getPack(id);
  }

  @override
  Future<PacksResponse> getPacksParParametre(
      GetPacksParParametreRequest getPacksParParametreRequest) async {
    return await _appServiceClient.getPacksParParametre(
        getPacksParParametreRequest.ville,
        dateDebut: getPacksParParametreRequest.dateDebut,
        dateFin: getPacksParParametreRequest.dateFin,
        nbrPersonnes: getPacksParParametreRequest.nbrPersonnes);
  }

  @override
  Future<PaysResponse> getPays() async {
    return await _appServiceClient.getPays();
  }

  @override
  Future<ReservationResponse> getReservation(String id) async {
    return await _appServiceClient.getReservation(id);
  }

  @override
  Future<ReservationsResponse> getReservationParParametre(
      GetReservationParParametreRequest
          getReservationParParametreRequest) async {
    return await _appServiceClient.getReservationParParametre(
        userId: getReservationParParametreRequest.userId,
        type: getReservationParParametreRequest.type,
        proprietaireId: getReservationParParametreRequest.proprietaireId);
  }

  @override
  Future<RestaurantResponse> getRestaurant(String id) async {
    return await _appServiceClient.getRestaurant(id);
  }

  @override
  Future<RestaurantsResponse> getRestaurantsParProprietaireId(
      String proprietaireId) async {
    return await _appServiceClient
        .getRestaurantsParProprietaireId(proprietaireId);
  }

  @override
  Future<RestaurantsResponse> getRestaurantsParVille(String ville) async {
    return await _appServiceClient.getRestaurantsParVille(ville);
  }

  @override
  Future<AuthenticationResponse> getUser({String? id}) async {
    return await _appServiceClient.getUser(id: id);
  }

  @override
  Future<VillesResponse> getVillesParPaye(String payeId) async {
    return await _appServiceClient.getVillesParPaye(payeId);
  }

  @override
  Future<HebergmentsResponse> gethebergmentsParParametre(
      GethebergmentsParParametreRequest
          gethebergmentsParParametreRequest) async {
    return await _appServiceClient.gethebergmentsParParametre(
        gethebergmentsParParametreRequest.ville,
        categorie: gethebergmentsParParametreRequest.categorie,
        dateDebut: gethebergmentsParParametreRequest.dateDebut,
        dateFin: gethebergmentsParParametreRequest.dateFin,
        nbrPersonnes: gethebergmentsParParametreRequest.nbrPersonnes);
  }

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<AuthenticationResponse> logout() async {
    return await _appServiceClient.logout();
  }

  @override
  Future<PackResponse> postPack(PostPackRequest postPackRequest) async {
    return await _appServiceClient.postPack(
        postPackRequest.name,
        postPackRequest.description,
        postPackRequest.photoCoverture,
        postPackRequest.photos,
        postPackRequest.villesId,
        postPackRequest.activites,
        postPackRequest.hebergments,
        postPackRequest.restaurants,
        postPackRequest.nbrPlace,
        postPackRequest.nbrPlaceDisp,
        postPackRequest.dateDebut,
        postPackRequest.dateFin,
        postPackRequest.prix,
        postPackRequest.proprietaireId);
  }

  @override
  Future<ReservationResponse> postReservation(
      PostReservationRequest postReservationRequest) async {
    return await _appServiceClient.postReservation(
        postReservationRequest.userId,
        postReservationRequest.proprietaireId,
        postReservationRequest.type,
        postReservationRequest.serviceId,
        postReservationRequest.nbrPersonne,
        postReservationRequest.dateDebut,
        postReservationRequest.dateFin);
  }

  @override
  Future<RestaurantResponse> postRestaurant(
      PostRestaurantRequest postRestaurantRequest) async {
    return await _appServiceClient.postRestaurant(
        postRestaurantRequest.name,
        postRestaurantRequest.description,
        postRestaurantRequest.photoCoverture,
        postRestaurantRequest.latitude,
        postRestaurantRequest.longitude,
        postRestaurantRequest.villeId,
        postRestaurantRequest.photos,
        postRestaurantRequest.proprietaireId);
  }

  @override
  Future<HebergmentResponse> posthebergment(
      PosthebergmentRequest posthebergmentRequest) async {
    return await _appServiceClient.posthebergment(
        posthebergmentRequest.name,
        posthebergmentRequest.villeId,
        posthebergmentRequest.nbrVoyager,
        posthebergmentRequest.nbrPlaceDisp,
        posthebergmentRequest.nbrChambreDisp,
        posthebergmentRequest.nbrChambreIndiv,
        posthebergmentRequest.nbrChambreDeux,
        posthebergmentRequest.nbrChambreTrois,
        posthebergmentRequest.nbrSuits,
        posthebergmentRequest.prixChambreIndiv,
        posthebergmentRequest.prixChambreDeux,
        posthebergmentRequest.prixChambreTrois,
        posthebergmentRequest.prixSuits,
        posthebergmentRequest.categorie,
        posthebergmentRequest.description,
        posthebergmentRequest.photoCoverture,
        posthebergmentRequest.latitude,
        posthebergmentRequest.longitude,
        posthebergmentRequest.photos,
        posthebergmentRequest.dateDebut,
        posthebergmentRequest.dateFin,
        posthebergmentRequest.proprietaireId);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.email,
        registerRequest.password,
        registerRequest.firstName,
        registerRequest.lastName,
        registerRequest.villeId,
        registerRequest.userType,
        registerRequest.phone,
        registerRequest.civilite,
        registerRequest.photo,
        registerRequest.points);
  }

  @override
  Future<ImageResponse> storeImage(XFile imageFile) async {
    return await _appServiceClient.storeImage(imageFile);
  }

  @override
  Future<PackResponse> upDatePack(UpDatePackRequest upDatePackRequest) async {
    return await _appServiceClient.upDatePack(upDatePackRequest.id,
        activites: upDatePackRequest.activites,
        dateDebut: upDatePackRequest.dateDebut,
        dateFin: upDatePackRequest.dateFin,
        description: upDatePackRequest.description,
        hebergments: upDatePackRequest.hebergments,
        name: upDatePackRequest.name,
        nbrPlace: upDatePackRequest.nbrPlace,
        nbrPlaceDisp: upDatePackRequest.nbrPlaceDisp,
        photoCoverture: upDatePackRequest.photoCoverture,
        photos: upDatePackRequest.photos,
        prix: upDatePackRequest.prix,
        restaurants: upDatePackRequest.restaurants,
        villesId: upDatePackRequest.villesId);
  }

  @override
  Future<AuthenticationResponse> updateProfil(
      UpdateProfilReques updateProfilReques,
      {String? id}) async {
    return await _appServiceClient.updateProfil(
      id: id,
      civilite: updateProfilReques.civilite,
      firstName: updateProfilReques.firstName,
      lastName: updateProfilReques.lastName,
      password: updateProfilReques.password,
      phone: updateProfilReques.phone,
      photo: updateProfilReques.photo,
      points: updateProfilReques.point,
      villeId: updateProfilReques.villeId,
    );
  }

  @override
  Future<ReservationResponse> updateReservation(
      UpdateReservationRequest updateReservationRequest) async {
    return await _appServiceClient.updateReservation(
        updateReservationRequest.id,
        updateReservationRequest.type,
        updateReservationRequest.dateDebut,
        updateReservationRequest.dateFin);
  }

  @override
  Future<RestaurantResponse> updateRestaurant(
      UpdateRestaurantRequest updateRestaurantRequest) async {
    return await _appServiceClient.updateRestaurant(
      updateRestaurantRequest.id,
      description: updateRestaurantRequest.description,
      latitude: updateRestaurantRequest.latitude,
      longitude: updateRestaurantRequest.longitude,
      name: updateRestaurantRequest.name,
      photoCoverture: updateRestaurantRequest.photoCoverture,
      photos: updateRestaurantRequest.photos,
      villeId: updateRestaurantRequest.villeId,
    );
  }

  @override
  Future<HebergmentResponse> updatehebergment(
      UpdatehebergmentRequest updatehebergmentRequest) async {
    return await _appServiceClient.updatehebergment(
      updatehebergmentRequest.id,
      categorie: updatehebergmentRequest.categorie,
      dateDebut: updatehebergmentRequest.dateDebut,
      dateFin: updatehebergmentRequest.dateFin,
      description: updatehebergmentRequest.description,
      latitude: updatehebergmentRequest.latitude,
      longitude: updatehebergmentRequest.longitude,
      name: updatehebergmentRequest.name,
      nbrChambreDeux: updatehebergmentRequest.nbrChambreDeux,
      nbrChambreDisp: updatehebergmentRequest.nbrChambreDisp,
      nbrChambreIndiv: updatehebergmentRequest.nbrChambreIndiv,
      nbrChambreTrois: updatehebergmentRequest.nbrChambreTrois,
      nbrPlaceDisp: updatehebergmentRequest.nbrPlaceDisp,
      nbrSuits: updatehebergmentRequest.nbrSuits,
      nbrVoyager: updatehebergmentRequest.nbrVoyager,
      photoCoverture: updatehebergmentRequest.photoCoverture,
      photos: updatehebergmentRequest.photos,
      prixChambreDeux: updatehebergmentRequest.prixChambreDeux,
      prixChambreIndiv: updatehebergmentRequest.prixChambreIndiv,
      prixChambreTrois: updatehebergmentRequest.prixChambreTrois,
      prixSuit: updatehebergmentRequest.prixSuit,
      villeId: updatehebergmentRequest.villeId,
    );
  }

  @override
  Future<HebergmentsResponse> getHebergmentsParProprietaireId(
      String proprietaireId) async {
    return await _appServiceClient
        .getHebergmentsParProprietaireId(proprietaireId);
  }

  @override
  Future<PacksResponse> getPacksParProprietaireId(String proprietaireId) async {
    return await _appServiceClient.getPacksParProprietaireId(proprietaireId);
  }
}
