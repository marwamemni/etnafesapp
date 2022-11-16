// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  String email;
  String password;
  String firstName;
  String lastName;
  String villeId;
  String userType;
  String phone;
  String civilite;
  String photo;
  double points;
  RegisterRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.villeId,
    required this.userType,
    required this.phone,
    required this.civilite,
    required this.photo,
    required this.points,
  });
}

class UpdateProfilReques {
  String? password;
  String? firstName;
  String? lastName;
  String? villeId;
  String? phone;
  String? civilite;
  String? photo;
  double? point;
  UpdateProfilReques({
    this.password,
    this.firstName,
    this.lastName,
    this.villeId,
    this.phone,
    this.civilite,
    this.photo,
    this.point,
  });
}

class PostRestaurantRequest {
  String name;
  String description;
  String photoCoverture;
  double latitude;
  double longitude;
  String villeId;
  List<String> photos;
  String proprietaireId;
  PostRestaurantRequest({
    required this.name,
    required this.description,
    required this.photoCoverture,
    required this.latitude,
    required this.longitude,
    required this.villeId,
    required this.photos,
    required this.proprietaireId,
  });
}

class UpdateRestaurantRequest {
  String id;
  String? name;
  String? description;
  String? photoCoverture;
  double? latitude;
  double? longitude;
  String? villeId;
  List<String>? photos;
  UpdateRestaurantRequest({
    required this.id,
    this.name,
    this.description,
    this.photoCoverture,
    this.latitude,
    this.longitude,
    this.villeId,
    this.photos,
  });
}

class PosthebergmentRequest {
  String name;
  String villeId;
  int nbrVoyager;
  int nbrPlaceDisp;
  int nbrChambreDisp;
  int nbrChambreIndiv;
  int nbrChambreDeux;
  int nbrChambreTrois;
  int nbrSuits;
  double prixChambreIndiv;
  double prixChambreDeux;
  double prixChambreTrois;
  double prixSuits;
  String categorie;
  String description;
  String photoCoverture;
  double latitude;
  double longitude;
  List<String> photos;
  DateTime dateDebut;
  DateTime dateFin;
  String proprietaireId;
  PosthebergmentRequest({
    required this.name,
    required this.villeId,
    required this.nbrVoyager,
    required this.nbrPlaceDisp,
    required this.nbrChambreDisp,
    required this.nbrChambreIndiv,
    required this.nbrChambreDeux,
    required this.nbrChambreTrois,
    required this.nbrSuits,
    required this.prixChambreIndiv,
    required this.prixChambreDeux,
    required this.prixChambreTrois,
    required this.prixSuits,
    required this.categorie,
    required this.description,
    required this.photoCoverture,
    required this.latitude,
    required this.longitude,
    required this.photos,
    required this.dateDebut,
    required this.dateFin,
    required this.proprietaireId,
  });
}

class UpdatehebergmentRequest {
  String id;
  String? name;
  String? villeId;
  int? nbrVoyager;
  int? nbrPlaceDisp;
  int? nbrChambreDisp;
  int? nbrChambreIndiv;
  int? nbrChambreDeux;
  int? nbrChambreTrois;
  int? nbrSuits;
  double? prixChambreIndiv;
  double? prixChambreDeux;
  double? prixChambreTrois;
  double? prixSuit;
  String? categorie;
  String? description;
  String? photoCoverture;
  double? latitude;
  double? longitude;
  List<String>? photos;
  DateTime? dateDebut;
  DateTime? dateFin;
  UpdatehebergmentRequest({
    required this.id,
    this.name,
    this.villeId,
    this.nbrVoyager,
    this.nbrPlaceDisp,
    this.nbrChambreDisp,
    this.nbrChambreIndiv,
    this.nbrChambreDeux,
    this.nbrChambreTrois,
    this.nbrSuits,
    this.prixChambreIndiv,
    this.prixChambreDeux,
    this.prixChambreTrois,
    this.prixSuit,
    this.categorie,
    this.description,
    this.photoCoverture,
    this.latitude,
    this.longitude,
    this.photos,
    this.dateDebut,
    this.dateFin,
  });
}

class GethebergmentsParParametreRequest {
  String ville;
  DateTime? dateDebut;
  DateTime? dateFin;
  int? nbrPersonnes;
  String? categorie;
  GethebergmentsParParametreRequest({
    required this.ville,
    this.dateDebut,
    this.dateFin,
    this.nbrPersonnes,
    this.categorie,
  });
}

class PostPackRequest {
  String name;
  String description;
  String photoCoverture;
  List<String> photos;
  List<String> villesId;
  List<String> activites;
  List<String> hebergments;
  List<String> restaurants;
  int nbrPlace;
  int nbrPlaceDisp;
  DateTime dateDebut;
  DateTime dateFin;
  double prix;
  String proprietaireId;
  PostPackRequest({
    required this.name,
    required this.description,
    required this.photoCoverture,
    required this.photos,
    required this.villesId,
    required this.activites,
    required this.hebergments,
    required this.restaurants,
    required this.nbrPlace,
    required this.nbrPlaceDisp,
    required this.dateDebut,
    required this.dateFin,
    required this.prix,
    required this.proprietaireId,
  });
}

class UpDatePackRequest {
  String id;
  String? name;
  String? description;
  String? photoCoverture;
  List<String>? photos;
  List<String>? villesId;
  List<String>? activites;
  List<String>? hebergments;
  List<String>? restaurants;
  int? nbrPlace;
  int? nbrPlaceDisp;
  DateTime? dateDebut;
  DateTime? dateFin;
  double? prix;
  UpDatePackRequest({
    required this.id,
    this.name,
    this.description,
    this.photoCoverture,
    this.photos,
    this.villesId,
    this.activites,
    this.hebergments,
    this.restaurants,
    this.nbrPlace,
    this.nbrPlaceDisp,
    this.dateDebut,
    this.dateFin,
    this.prix,
  });
}

class GetPacksParParametreRequest {
  String ville;
  DateTime? dateDebut;
  DateTime? dateFin;
  int? nbrPersonnes;
  GetPacksParParametreRequest({
    required this.ville,
    this.dateDebut,
    this.dateFin,
    this.nbrPersonnes,
  });
}

class PostReservationRequest {
  String userId;
  String proprietaireId;
  String type;
  String serviceId;
  int nbrPersonne;
  DateTime dateDebut;
  DateTime dateFin;
  PostReservationRequest({
    required this.userId,
    required this.proprietaireId,
    required this.type,
    required this.serviceId,
    required this.nbrPersonne,
    required this.dateDebut,
    required this.dateFin,
  });
}

class UpdateReservationRequest {
  String id;
  DateTime? dateDebut;
  DateTime? dateFin;
  String type;
  UpdateReservationRequest(this.id, this.type, [this.dateDebut, this.dateFin]);
}

class GetReservationParParametreRequest {
  String? userId;
  String? proprietaireId;
  String? type;
  GetReservationParParametreRequest({
    this.userId,
    this.proprietaireId,
    this.type,
  });
}
