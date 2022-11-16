// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['status'] as int?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

DefaultResponse _$DefaultResponseFromJson(Map<String, dynamic> json) =>
    DefaultResponse()
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$DefaultResponseToJson(DefaultResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['id'] as String?,
      json['fisrt_name'] as String?,
      json['last_name'] as String?,
      json['user_type'] as String?,
      json['villeId'] as String?,
      json['civilite'] as String?,
      json['photo'] as String?,
      (json['points'] as num?)?.toDouble(),
      json['phone'] as String?,
      json['email'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'id': instance.id,
      'fisrt_name': instance.firstName,
      'last_name': instance.lastName,
      'user_type': instance.userType,
      'villeId': instance.villeId,
      'civilite': instance.civilite,
      'photo': instance.photo,
      'points': instance.points,
      'phone': instance.phone,
      'email': instance.email,
    };

PayeResponse _$PayeResponseFromJson(Map<String, dynamic> json) => PayeResponse(
      json['id'] as String?,
      json['code'] as int?,
      json['name'] as String?,
    );

Map<String, dynamic> _$PayeResponseToJson(PayeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };

PaysResponse _$PaysResponseFromJson(Map<String, dynamic> json) => PaysResponse(
      (json['pays'] as List<dynamic>?)
          ?.map((e) => PayeResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$PaysResponseToJson(PaysResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'pays': instance.pays,
    };

VilleResponse _$VilleResponseFromJson(Map<String, dynamic> json) =>
    VilleResponse(
      json['id'] as String?,
      json['name'] as String?,
      json['photo'] as String?,
      json['paye_id'] as String?,
    );

Map<String, dynamic> _$VilleResponseToJson(VilleResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'paye_id': instance.payeId,
    };

VillesResponse _$VillesResponseFromJson(Map<String, dynamic> json) =>
    VillesResponse(
      (json['villes'] as List<dynamic>?)
          ?.map((e) => VilleResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$VillesResponseToJson(VillesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'villes': instance.villes,
    };

RestaurantDataResponse _$RestaurantDataResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantDataResponse(
      json['id'] as String?,
      json['name'] as String?,
      json['description'] as String?,
      json['photo_coverture'] as String?,
      json['ville_id'] as String?,
      (json['latitude'] as num?)?.toDouble(),
      (json['longitude'] as num?)?.toDouble(),
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['proprietaire_id'] as String?,
    );

Map<String, dynamic> _$RestaurantDataResponseToJson(
        RestaurantDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photo_coverture': instance.photoCoverture,
      'ville_id': instance.villeId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'photos': instance.photos,
      'proprietaire_id': instance.proprietaireId,
    };

RestaurantResponse _$RestaurantResponseFromJson(Map<String, dynamic> json) =>
    RestaurantResponse(
      json['id'] as String?,
      json['name'] as String?,
      json['description'] as String?,
      json['photo_coverture'] as String?,
      json['ville_id'] as String?,
      (json['latitude'] as num?)?.toDouble(),
      (json['longitude'] as num?)?.toDouble(),
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['proprietaire_id'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$RestaurantResponseToJson(RestaurantResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photo_coverture': instance.photoCoverture,
      'ville_id': instance.villeId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'photos': instance.photos,
      'proprietaire_id': instance.proprietaireId,
    };

RestaurantsResponse _$RestaurantsResponseFromJson(Map<String, dynamic> json) =>
    RestaurantsResponse(
      (json['restaurants'] as List<dynamic>?)
          ?.map(
              (e) => RestaurantDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$RestaurantsResponseToJson(
        RestaurantsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'restaurants': instance.restaurants,
    };

HebergmentDataResponse _$HebergmentDataResponseFromJson(
        Map<String, dynamic> json) =>
    HebergmentDataResponse(
      json['id'] as String?,
      json['name'] as String?,
      json['ville_id'] as String?,
      json['nbr_voyager'] as int?,
      json['nbr_place_disp'] as int?,
      json['nbr_chambre_disp'] as int?,
      json['nbr_chambre_indiv'] as int?,
      json['nbr_chambre_deux'] as int?,
      json['nbr_chambre_trois'] as int?,
      json['nbr_suit'] as int?,
      (json['prix_chambre_indiv'] as num?)?.toDouble(),
      (json['prix_chambre_deux'] as num?)?.toDouble(),
      (json['prix_chambre_trois'] as num?)?.toDouble(),
      (json['prix_suit'] as num?)?.toDouble(),
      json['categorie'] as String?,
      json['description'] as String?,
      json['photo_coverture'] as String?,
      (json['latitude'] as num?)?.toDouble(),
      (json['longitude'] as num?)?.toDouble(),
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['date_debut'] == null
          ? null
          : (json['date_debut'] as Timestamp).toDate(),
      json['date_fin'] == null
          ? null
          : (json['date_fin'] as Timestamp).toDate(),
      json['proprietaire_id'] as String?,
    );

Map<String, dynamic> _$HebergmentDataResponseToJson(
        HebergmentDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ville_id': instance.villeId,
      'nbr_voyager': instance.nbrVoyager,
      'nbr_place_disp': instance.nbrPlaceDisp,
      'nbr_chambre_disp': instance.nbrChambreDisp,
      'nbr_chambre_indiv': instance.nbrChambreIndiv,
      'nbr_chambre_deux': instance.nbrChambreDeux,
      'nbr_chambre_trois': instance.nbrChambreTrois,
      'nbr_suit': instance.nbrSuit,
      'prix_chambre_indiv': instance.prixChambreIndiv,
      'prix_chambre_deux': instance.prixChambreDeux,
      'prix_chambre_trois': instance.prixChambreTrois,
      'prix_suit': instance.prixSuit,
      'categorie': instance.categorie,
      'description': instance.description,
      'photo_coverture': instance.photoCoverture,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'photos': instance.photos,
      'date_debut': instance.dateDebut?.toIso8601String(),
      'date_fin': instance.dateFin?.toIso8601String(),
      'proprietaire_id': instance.proprietaireId,
    };

HebergmentResponse _$HebergmentResponseFromJson(Map<String, dynamic> json) =>
    HebergmentResponse(
      json['id'] as String?,
      json['name'] as String?,
      json['ville_id'] as String?,
      json['nbr_voyager'] as int?,
      json['nbr_place_disp'] as int?,
      json['nbr_chambre_disp'] as int?,
      json['nbr_chambre_indiv'] as int?,
      json['nbr_chambre_deux'] as int?,
      json['nbr_chambre_trois'] as int?,
      json['nbr_suit'] as int?,
      (json['prix_chambre_indiv'] as num?)?.toDouble(),
      (json['prix_chambre_deux'] as num?)?.toDouble(),
      (json['prix_chambre_trois'] as num?)?.toDouble(),
      (json['prix_suit'] as num?)?.toDouble(),
      json['categorie'] as String?,
      json['description'] as String?,
      json['photo_coverture'] as String?,
      (json['latitude'] as num?)?.toDouble(),
      (json['longitude'] as num?)?.toDouble(),
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['date_debut'] == null
          ? null
          : (json['date_debut'] as Timestamp).toDate(),
      json['date_fin'] == null
          ? null
          : (json['date_fin'] as Timestamp).toDate(),
      json['proprietaire_id'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$HebergmentResponseToJson(HebergmentResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'id': instance.id,
      'name': instance.name,
      'ville_id': instance.villeId,
      'nbr_voyager': instance.nbrVoyager,
      'nbr_place_disp': instance.nbrPlaceDisp,
      'nbr_chambre_disp': instance.nbrChambreDisp,
      'nbr_chambre_indiv': instance.nbrChambreIndiv,
      'nbr_chambre_deux': instance.nbrChambreDeux,
      'nbr_chambre_trois': instance.nbrChambreTrois,
      'nbr_suit': instance.nbrSuit,
      'prix_chambre_indiv': instance.prixChambreIndiv,
      'prix_chambre_deux': instance.prixChambreDeux,
      'prix_chambre_trois': instance.prixChambreTrois,
      'prix_suit': instance.prixSuit,
      'categorie': instance.categorie,
      'description': instance.description,
      'photo_coverture': instance.photoCoverture,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'photos': instance.photos,
      'date_debut': instance.dateDebut?.toIso8601String(),
      'date_fin': instance.dateFin?.toIso8601String(),
      'proprietaire_id': instance.proprietaireId,
    };

HebergmentsResponse _$HebergmentsResponseFromJson(Map<String, dynamic> json) =>
    HebergmentsResponse(
      (json['hebergments'] as List<dynamic>?)
          ?.map(
              (e) => HebergmentDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$HebergmentsResponseToJson(
        HebergmentsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'hebergments': instance.hebergments,
    };

ReservationResponse _$ReservationResponseFromJson(Map<String, dynamic> json) =>
    ReservationResponse(
      json['id'] as String?,
      json['user_id'] as String?,
      json['proprietaire_id'] as String?,
      json['type'] as String?,
      json['service_id'] as String?,
      json['nbr_personne'] as int?,
      json['date_debut'] == null
          ? null
          : (json['date_debut'] as Timestamp).toDate(),
      json['date_fin'] == null
          ? null
          : (json['date_fin'] as Timestamp).toDate(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ReservationResponseToJson(
        ReservationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'id': instance.id,
      'user_id': instance.userId,
      'proprietaire_id': instance.proprietaireId,
      'type': instance.type,
      'service_id': instance.serviceId,
      'nbr_personne': instance.nbrPersonne,
      'date_debut': instance.dateDebut?.toIso8601String(),
      'date_fin': instance.dateFin?.toIso8601String(),
    };

ReservationDataResponse _$ReservationDataResponseFromJson(
        Map<String, dynamic> json) =>
    ReservationDataResponse(
      json['id'] as String?,
      json['user_id'] as String?,
      json['proprietaire_id'] as String?,
      json['type'] as String?,
      json['service_id'] as String?,
      json['nbr_personne'] as int?,
      json['date_debut'] == null
          ? null
          : (json['date_debut'] as Timestamp).toDate(),
      json['date_fin'] == null
          ? null
          : (json['date_fin'] as Timestamp).toDate(),
    );

Map<String, dynamic> _$ReservationDataResponseToJson(
        ReservationDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'proprietaire_id': instance.proprietaireId,
      'type': instance.type,
      'service_id': instance.serviceId,
      'nbr_personne': instance.nbrPersonne,
      'date_debut': instance.dateDebut?.toIso8601String(),
      'date_fin': instance.dateFin?.toIso8601String(),
    };

ReservationsResponse _$ReservationsResponseFromJson(
        Map<String, dynamic> json) =>
    ReservationsResponse(
      (json['reservations'] as List<dynamic>?)
          ?.map((e) =>
              ReservationDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ReservationsResponseToJson(
        ReservationsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'reservations': instance.reservations,
    };

PackResponse _$PackResponseFromJson(Map<String, dynamic> json) => PackResponse(
      json['id'] as String?,
      json['name'] as String?,
      json['description'] as String?,
      json['photo_coverture'] as String?,
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['villes_id'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['activites'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['hebergments'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['restaurants'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['nbr_place'] as int?,
      json['nbr_plce_disp'] as int?,
      json['date_debut'] == null
          ? null
          : (json['date_debut'] as Timestamp).toDate(),
      json['date_fin'] == null
          ? null
          : (json['date_fin'] as Timestamp).toDate(),
      json['proprietaire_id'] as String?,
      (json['prix'] as num?)?.toDouble(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$PackResponseToJson(PackResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photo_coverture': instance.photoCoverture,
      'photos': instance.photos,
      'villes_id': instance.villesId,
      'activites': instance.activites,
      'hebergments': instance.hebergments,
      'restaurants': instance.restaurants,
      'nbr_place': instance.nbrPlace,
      'nbr_plce_disp': instance.nbrPlaceDisp,
      'date_debut': instance.dateDebut?.toIso8601String(),
      'date_fin': instance.dateFin?.toIso8601String(),
      'proprietaire_id': instance.proprietaireId,
    };

PackDataResponse _$PackDataResponseFromJson(Map<String, dynamic> json) =>
    PackDataResponse(
      json['id'] as String?,
      json['name'] as String?,
      json['description'] as String?,
      json['photo_coverture'] as String?,
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['villes_id'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['activites'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['hebergments'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['restaurants'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['nbr_place'] as int?,
      json['nbr_plce_disp'] as int?,
      json['date_debut'] == null
          ? null
          : (json['date_debut'] as Timestamp).toDate(),
      json['date_fin'] == null
          ? null
          : (json['date_fin'] as Timestamp).toDate(),
      json['proprietaire_id'] as String?,
      (json['prix'] as num?)?.toDouble(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$PackDataResponseToJson(PackDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photo_coverture': instance.photoCoverture,
      'photos': instance.photos,
      'villes_id': instance.villesId,
      'activites': instance.activites,
      'hebergments': instance.hebergments,
      'restaurants': instance.restaurants,
      'nbr_place': instance.nbrPlace,
      'nbr_plce_disp': instance.nbrPlaceDisp,
      'date_debut': instance.dateDebut?.toIso8601String(),
      'date_fin': instance.dateFin?.toIso8601String(),
      'prix': instance.prix,
      'proprietaire_id': instance.proprietaireId,
    };

PacksResponse _$PacksResponseFromJson(Map<String, dynamic> json) =>
    PacksResponse(
      (json['packs'] as List<dynamic>?)
          ?.map((e) => PackDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$PacksResponseToJson(PacksResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'packs': instance.packs,
    };

ImageResponse _$ImageResponseFromJson(Map<String, dynamic> json) =>
    ImageResponse(
      json['image_url'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ImageResponseToJson(ImageResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'image_url': instance.imageUrl,
    };
