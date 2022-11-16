import 'package:agence_voyage/data/response/responses.dart';
import 'package:image_picker/image_picker.dart';

abstract class AppServiceClient {
  //Authentication services
  Future<AuthenticationResponse> login(String email, String password);

  Future<DefaultResponse> forgotPassword(String email);

  Future<AuthenticationResponse> register(
      String email,
      String password,
      String firstName,
      String lastName,
      String villeId,
      String userType,
      String phone,
      String civilite,
      String photo,
      double points);

  Future<AuthenticationResponse> logout();

  Future<AuthenticationResponse> updateProfil(
      {String? id,
      String? password,
      String? firstName,
      String? lastName,
      String? villeId,
      String? phone,
      String? civilite,
      String? photo,
      double? points});

  Future<AuthenticationResponse> getUser({String? id});

  //Ville services
  Future<PaysResponse> getPays();

  Future<VillesResponse> getVillesParPaye(String payeId);

  //Restaurant services
  Future<RestaurantResponse> postRestaurant(
      String name,
      String description,
      String photoCoverture,
      double latitude,
      double longitude,
      String villeId,
      List<String> photos,
      String proprietaireId);

  Future<RestaurantResponse> updateRestaurant(
    String id, {
    String? name,
    String? description,
    String? photoCoverture,
    double? latitude,
    double? longitude,
    String? villeId,
    List<String>? photos,
  });

  Future<RestaurantResponse> getRestaurant(String id);

  Future<RestaurantsResponse> getRestaurantsParVille(String ville);

  Future<RestaurantsResponse> getRestaurantsParProprietaireId(
      String proprietaireId);

  Future<DefaultResponse> deleteRestaurant(String id);

  //hebergment services
  Future<HebergmentResponse> posthebergment(
    String name,
    String villeId,
    int nbrVoyager,
    int nbrPlaceDisp,
    int nbrChambreDisp,
    int nbrChambreIndiv,
    int nbrChambreDeux,
    int nbrChambreTrois,
    int nbrSuits,
    double prixChambreIndiv,
    double prixChambreDeux,
    double prixChambreTrois,
    double prixSuits,
    String categorie,
    String description,
    String photoCoverture,
    double latitude,
    double longitude,
    List<String> photos,
    DateTime dateDebut,
    DateTime dateFin,
    String proprietaireId,
  );

  Future<HebergmentResponse> updatehebergment(
    String id, {
    String? name,
    String? villeId,
    int? nbrVoyager,
    int? nbrPlaceDisp,
    int? nbrChambreDisp,
    int? nbrChambreIndiv,
    int? nbrChambreDeux,
    int? nbrChambreTrois,
    int? nbrSuits,
    double? prixChambreIndiv,
    double? prixChambreDeux,
    double? prixChambreTrois,
    double? prixSuit,
    String? categorie,
    String? description,
    String? photoCoverture,
    double? latitude,
    double? longitude,
    List<String>? photos,
    DateTime? dateDebut,
    DateTime? dateFin,
  });

  Future<HebergmentResponse> getHebergment(String id);

  Future<DefaultResponse> deleteHebergment(String id);

  Future<HebergmentsResponse> gethebergmentsParParametre(String ville,
      {DateTime? dateDebut,
      DateTime? dateFin,
      int? nbrPersonnes,
      String? categorie});

  Future<HebergmentsResponse> getHebergmentsParProprietaireId(
      String proprietaireId);

  //Pack services
  Future<PackResponse> postPack(
    String name,
    String description,
    String photoCoverture,
    List<String> photos,
    List<String> villesId,
    List<String> activites,
    List<String> hebergments,
    List<String> restaurants,
    int nbrPlace,
    int nbrPlaceDisp,
    DateTime dateDebut,
    DateTime dateFin,
    double prix,
    String proprietaireId,
  );

  Future<PackResponse> upDatePack(
    String id, {
    String? name,
    String? description,
    String? photoCoverture,
    List<String>? photos,
    List<String>? villesId,
    List<String>? activites,
    List<String>? hebergments,
    List<String>? restaurants,
    int? nbrPlace,
    int? nbrPlaceDisp,
    DateTime? dateDebut,
    DateTime? dateFin,
    double? prix,
  });

  Future<PackResponse> getPack(String id);

  Future<DefaultResponse> deletePack(String id);

  Future<PacksResponse> getPacksParParametre(
    String ville, {
    DateTime? dateDebut,
    DateTime? dateFin,
    int? nbrPersonnes,
  });

  Future<PacksResponse> getPacksParProprietaireId(String proprietaireId);

  //Reservation services
  Future<ReservationResponse> postReservation(
      String userId,
      String proprietaireId,
      String type,
      String serviceId,
      int nbrPersonne,
      DateTime dateDebut,
      DateTime dateFin);

  Future<ReservationResponse> updateReservation(String id, String type,
      [DateTime? dateDebut, DateTime? dateFin]);

  Future<ReservationResponse> getReservation(String id);

  Future<DefaultResponse> deleteReservation(String id);

  Future<ReservationsResponse> getReservationParParametre({
    String? userId,
    String? proprietaireId,
    String? type,
  });

  //Image services
  Future<ImageResponse> storeImage(XFile imageFile);
  Future<DefaultResponse> deleteImage(String imageUrl);
}
