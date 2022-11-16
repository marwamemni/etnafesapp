import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
//base response
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

//Default response
@JsonSerializable()
class DefaultResponse extends BaseResponse {
  DefaultResponse();

  // from json
  factory DefaultResponse.fromJson(Map<String, dynamic> json) =>
      _$DefaultResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$DefaultResponseToJson(this);
}

//authentication response
@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "fisrt_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "user_type")
  String? userType;
  @JsonKey(name: "villeId")
  String? villeId;
  @JsonKey(name: "civilite")
  String? civilite;
  @JsonKey(name: "photo")
  String? photo;
  @JsonKey(name: "points")
  double? points;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;

  AuthenticationResponse(
    this.id,
    this.firstName,
    this.lastName,
    this.userType,
    this.villeId,
    this.civilite,
    this.photo,
    this.points,
    this.phone,
    this.email,
  );

  // from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

//ville response
@JsonSerializable()
class PayeResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "name")
  String? name;
  PayeResponse(this.id, this.code, this.name);

  // from json
  factory PayeResponse.fromJson(Map<String, dynamic> json) =>
      _$PayeResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$PayeResponseToJson(this);
}

@JsonSerializable()
class PaysResponse extends BaseResponse {
  @JsonKey(name: "pays")
  List<PayeResponse>? pays;

  PaysResponse(this.pays);

  // from json
  factory PaysResponse.fromJson(Map<String, dynamic> json) =>
      _$PaysResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$PaysResponseToJson(this);
}

@JsonSerializable()
class VilleResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "photo")
  String? photo;
  @JsonKey(name: "paye_id")
  String? payeId;
  VilleResponse(
    this.id,
    this.name,
    this.photo,
    this.payeId,
  );

  // from json
  factory VilleResponse.fromJson(Map<String, dynamic> json) =>
      _$VilleResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$VilleResponseToJson(this);
}

@JsonSerializable()
class VillesResponse extends BaseResponse {
  @JsonKey(name: "villes")
  List<VilleResponse>? villes;
  VillesResponse(this.villes);

  // from json
  factory VillesResponse.fromJson(Map<String, dynamic> json) =>
      _$VillesResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$VillesResponseToJson(this);
}

//restaurant response
@JsonSerializable()
class RestaurantDataResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "photo_coverture")
  String? photoCoverture;
  @JsonKey(name: "ville_id")
  String? villeId;
  @JsonKey(name: "latitude")
  double? latitude;
  @JsonKey(name: "longitude")
  double? longitude;
  @JsonKey(name: "photos")
  List<String>? photos;
  @JsonKey(name: "proprietaire_id")
  String? proprietaireId;
  RestaurantDataResponse(
      this.id,
      this.name,
      this.description,
      this.photoCoverture,
      this.villeId,
      this.latitude,
      this.longitude,
      this.photos,
      this.proprietaireId);

  // from json
  factory RestaurantDataResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDataResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$RestaurantDataResponseToJson(this);
}

@JsonSerializable()
class RestaurantResponse extends RestaurantDataResponse with BaseResponse {
  RestaurantResponse(
      super.id,
      super.name,
      super.description,
      super.photoCoverture,
      super.villeId,
      super.latitude,
      super.longitude,
      super.photos,
      super.proprietaireId);

  // from json
  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResponseFromJson(json);

// to json
  @override
  Map<String, dynamic> toJson() => _$RestaurantResponseToJson(this);
}

@JsonSerializable()
class RestaurantsResponse extends BaseResponse {
  @JsonKey(name: "restaurants")
  List<RestaurantDataResponse>? restaurants;
  RestaurantsResponse(this.restaurants);

  // from json
  factory RestaurantsResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantsResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$RestaurantsResponseToJson(this);
}

//hebergment response
@JsonSerializable()
class HebergmentDataResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "ville_id")
  String? villeId;
  @JsonKey(name: "nbr_voyager")
  int? nbrVoyager;
  @JsonKey(name: "nbr_place_disp")
  int? nbrPlaceDisp;
  @JsonKey(name: "nbr_chambre_disp")
  int? nbrChambreDisp;
  @JsonKey(name: "nbr_chambre_indiv")
  int? nbrChambreIndiv;
  @JsonKey(name: "nbr_chambre_deux")
  int? nbrChambreDeux;
  @JsonKey(name: "nbr_chambre_trois")
  int? nbrChambreTrois;
  @JsonKey(name: "nbr_suit")
  int? nbrSuit;
  @JsonKey(name: "prix_chambre_indiv")
  double? prixChambreIndiv;
  @JsonKey(name: "prix_chambre_deux")
  double? prixChambreDeux;
  @JsonKey(name: "prix_chambre_trois")
  double? prixChambreTrois;
  @JsonKey(name: "prix_suit")
  double? prixSuit;
  @JsonKey(name: "categorie")
  String? categorie;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "photo_coverture")
  String? photoCoverture;
  @JsonKey(name: "latitude")
  double? latitude;
  @JsonKey(name: "longitude")
  double? longitude;
  @JsonKey(name: "photos")
  List<String>? photos;
  @JsonKey(name: "date_debut")
  DateTime? dateDebut;
  @JsonKey(name: "date_fin")
  DateTime? dateFin;
  @JsonKey(name: "proprietaire_id")
  String? proprietaireId;
  HebergmentDataResponse(
      this.id,
      this.name,
      this.villeId,
      this.nbrVoyager,
      this.nbrPlaceDisp,
      this.nbrChambreDisp,
      this.nbrChambreIndiv,
      this.nbrChambreDeux,
      this.nbrChambreTrois,
      this.nbrSuit,
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
      this.proprietaireId);

  // from json
  factory HebergmentDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HebergmentDataResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$HebergmentDataResponseToJson(this);
}

@JsonSerializable()
class HebergmentResponse extends HebergmentDataResponse with BaseResponse {
  HebergmentResponse(
      super.id,
      super.name,
      super.villeId,
      super.nbrVoyager,
      super.nbrPlaceDisp,
      super.nbrChambreDisp,
      super.nbrChambreIndiv,
      super.nbrChambreDeux,
      super.nbrChambreTrois,
      super.nbrSuit,
      super.prixChambreIndiv,
      super.prixChambreDeux,
      super.prixChambreTrois,
      super.prixSuit,
      super.categorie,
      super.description,
      super.photoCoverture,
      super.latitude,
      super.longitude,
      super.photos,
      super.dateDebut,
      super.dateFin,
      super.proprietaireId);

  // from json
  factory HebergmentResponse.fromJson(Map<String, dynamic> json) =>
      _$HebergmentResponseFromJson(json);

// to json
  @override
  Map<String, dynamic> toJson() => _$HebergmentResponseToJson(this);
}

@JsonSerializable()
class HebergmentsResponse extends BaseResponse {
  @JsonKey(name: "hebergments")
  List<HebergmentDataResponse>? hebergments;
  HebergmentsResponse(this.hebergments);

  // from json
  factory HebergmentsResponse.fromJson(Map<String, dynamic> json) =>
      _$HebergmentsResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$HebergmentsResponseToJson(this);
}

//reservation response
@JsonSerializable()
class ReservationDataResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "proprietaire_id")
  String? proprietaireId;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "service_id")
  String? serviceId;
  @JsonKey(name: "nbr_personne")
  int? nbrPersonne;
  @JsonKey(name: "date_debut")
  DateTime? dateDebut;
  @JsonKey(name: "date_fin")
  DateTime? dateFin;
  ReservationDataResponse(this.id, this.userId, this.proprietaireId, this.type,
      this.serviceId, this.nbrPersonne, this.dateDebut, this.dateFin);

  // from json
  factory ReservationDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ReservationDataResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$ReservationDataResponseToJson(this);
}

@JsonSerializable()
class ReservationResponse extends ReservationDataResponse with BaseResponse {
  ReservationResponse(super.id, super.userId, super.proprietaireId, super.type,
      super.serviceId, super.nbrPersonne, super.dateDebut, super.dateFin);

  // from json
  factory ReservationResponse.fromJson(Map<String, dynamic> json) =>
      _$ReservationResponseFromJson(json);

// to json
  @override
  Map<String, dynamic> toJson() => _$ReservationResponseToJson(this);
}

@JsonSerializable()
class ReservationsResponse extends BaseResponse {
  @JsonKey(name: "reservations")
  List<ReservationDataResponse>? reservations;
  ReservationsResponse(this.reservations);

  // from json
  factory ReservationsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReservationsResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$ReservationsResponseToJson(this);
}

//Pack response
@JsonSerializable()
class PackDataResponse extends BaseResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "photo_coverture")
  String? photoCoverture;
  @JsonKey(name: "photos")
  List<String>? photos;
  @JsonKey(name: "villes_id")
  List<String>? villesId;
  @JsonKey(name: "activites")
  List<String>? activites;
  @JsonKey(name: "hebergments")
  List<String>? hebergments;
  @JsonKey(name: "restaurants")
  List<String>? restaurants;
  @JsonKey(name: "nbr_place")
  int? nbrPlace;
  @JsonKey(name: "nbr_plce_disp")
  int? nbrPlaceDisp;
  @JsonKey(name: "date_debut")
  DateTime? dateDebut;
  @JsonKey(name: "date_fin")
  DateTime? dateFin;
  @JsonKey(name: "prix")
  double? prix;
  @JsonKey(name: "proprietaire_id")
  String? proprietaireId;
  PackDataResponse(
    this.id,
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
    this.proprietaireId,
    this.prix,
  );

  // from json
  factory PackDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PackDataResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$PackDataResponseToJson(this);
}

@JsonSerializable()
class PackResponse extends PackDataResponse with BaseResponse {
  PackResponse(
      super.id,
      super.name,
      super.description,
      super.photoCoverture,
      super.photos,
      super.villesId,
      super.activites,
      super.hebergments,
      super.restaurants,
      super.nbrPlace,
      super.nbrPlaceDisp,
      super.dateDebut,
      super.dateFin,
      super.proprietaireId,
      super.prix);

  // from json
  factory PackResponse.fromJson(Map<String, dynamic> json) =>
      _$PackResponseFromJson(json);

// to json
  @override
  Map<String, dynamic> toJson() => _$PackResponseToJson(this);
}

@JsonSerializable()
class PacksResponse extends BaseResponse {
  @JsonKey(name: "packs")
  List<PackDataResponse>? packs;
  PacksResponse(this.packs);

  // from json
  factory PacksResponse.fromJson(Map<String, dynamic> json) =>
      _$PacksResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$PacksResponseToJson(this);
}

//image response
@JsonSerializable()
class ImageResponse extends BaseResponse {
  @JsonKey(name: "image_url")
  String? imageUrl;
  ImageResponse(this.imageUrl);

  // from json
  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);
}
