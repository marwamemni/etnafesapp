import 'dart:io';

import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/data/network/app_api.dart';
import 'package:agence_voyage/data/response/responses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

//FireStore Collections
const String userCollection = 'users';
const String villeCollection = 'cities';
const String paysCollection = 'countries';
const String restaurantsCollection = 'restaurants';
const String hebergmentsCollection = 'hebergments';
const String packsCollection = 'packs';
const String reservationsCollection = 'reservations';
//FireStorage Folders
const String imagesFolder = "images";
//Main Responses
const successResponse = {"status": 0, "message": "SUCCESS"};

class AppServiceClientImp extends AppServiceClient {
  //FireBase tools initialation
  final _firebaseAuth = instance<FirebaseAuth>();
  final _firebaseStore = instance<FirebaseFirestore>();
  final _firebaseStorage = instance<FirebaseStorage>();

  //Authentication Section
  @override
  Future<AuthenticationResponse> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final response = await getUser();
      return response;
    } on FirebaseAuthException catch (e) {
      return AuthenticationResponse.fromJson({"status": 1, "message": e.code});
    } catch (e) {
      return AuthenticationResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<AuthenticationResponse> logout() async {
    try {
      await _firebaseAuth.signOut();
      return AuthenticationResponse.fromJson(
          {"status": 0, "message": "SUCCESS", "user_type": "VISITEUR"});
    } catch (e) {
      return AuthenticationResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
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
      double points) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return await _postUser(email, firstName, lastName, villeId, userType,
          phone, civilite, photo, points);
    } on FirebaseAuthException catch (e) {
      return AuthenticationResponse.fromJson({"status": 1, "message": e.code});
    } catch (e) {
      return AuthenticationResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<DefaultResponse> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return DefaultResponse.fromJson(successResponse);
    } catch (e) {
      return DefaultResponse.fromJson({"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<AuthenticationResponse> updateProfil(
      {String? id,
      String? password,
      String? firstName,
      String? lastName,
      String? villeId,
      String? phone,
      String? civilite,
      String? photo,
      double? points}) async {
    Map<String, dynamic> json = {};
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null || id != null) {
        if (password != null && user != null) {
          await user.updatePassword(password);
        }
        if (firstName != null) {
          json.addAll({'fisrt_name': firstName});
        }
        if (lastName != null) {
          json.addAll({'last_name': lastName});
        }
        if (villeId != null) {
          json.addAll({'villeId': villeId});
        }
        if (civilite != null) {
          json.addAll({'civilite': civilite});
        }
        if (photo != null) {
          json.addAll({'photo': photo});
        }
        if (phone != null) {
          json.addAll({'phone': phone});
        }
        if (points != null) {
          json.addAll({'points': points});
        }
        final doc =
            _firebaseStore.collection(userCollection).doc(id ?? user!.uid);
        await doc.update(json);
        Map<String, dynamic> response = (await doc.get()).data() ?? {};
        if (response == {}) {
          response.addAll({"status": 1, "message": "GET USER ERROR"});
        } else {
          response.addAll(successResponse);
        }
        return AuthenticationResponse.fromJson(response);
      } else {
        return AuthenticationResponse.fromJson(
            {"status": 1, "message": "USER==NULL"});
      }
    } catch (e) {
      return AuthenticationResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<AuthenticationResponse> getUser({String? id}) async {
    Map<String, dynamic>? json;
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null || id != null) {
        final userData = await _firebaseStore
            .collection(userCollection)
            .doc(id ?? user!.uid)
            .get();
        json = userData.data();
        json?.addAll(successResponse);
      } else {
        json = {"status": 1, "message": "USER==NULL"};
      }
    } catch (e) {
      json = {"status": 2, "message": e.toString()};
    }
    return AuthenticationResponse.fromJson(
        json ?? {"status": -2, "message": "NO DATA"});
  }

  //Ville Section
  @override
  Future<PaysResponse> getPays() async {
    try {
      final pays = await _getCollectionList(paysCollection);
      return PaysResponse.fromJson(
          {"status": 0, "message": "SUCCESS", "pays": pays});
    } catch (e) {
      return PaysResponse.fromJson({"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<VillesResponse> getVillesParPaye(String payeId) async {
    try {
      final dataList = await _getCollectionList(villeCollection);
      List<Map<String, dynamic>> villes = [];
      for (var ville in dataList) {
        if (ville["paye_id"] == payeId) {
          villes.add(ville);
        }
      }
      return VillesResponse.fromJson(
          {"status": 0, "message": "SUCCESS", "villes": villes});
    } catch (e) {
      return VillesResponse.fromJson({"status": 2, "message": e.toString()});
    }
  }

//Restaurant Section
  @override
  Future<RestaurantResponse> postRestaurant(
      String name,
      String description,
      String photoCoverture,
      double latitude,
      double longitude,
      String villeId,
      List<String> photos,
      String proprietaireId) async {
    try {
      final collection = _firebaseStore.collection(restaurantsCollection);
      final doc = collection.doc();
      Map<String, dynamic> json = {
        "id": doc.id,
        'name': name,
        'description': description,
        'photo_coverture': photoCoverture,
        'ville_id': villeId,
        'latitude': latitude,
        'longitude': longitude,
        'photos': photos,
        'proprietaire_id': proprietaireId,
      };
      await doc.set(json);
      json.addAll(successResponse);
      return RestaurantResponse.fromJson(json);
    } catch (e) {
      return RestaurantResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<RestaurantResponse> updateRestaurant(
    String id, {
    String? name,
    String? description,
    String? photoCoverture,
    double? latitude,
    double? longitude,
    String? villeId,
    List<String>? photos,
  }) async {
    try {
      final collection = _firebaseStore.collection(restaurantsCollection);
      final doc = collection.doc(id);
      Map<String, dynamic> map = {};
      if (name != null) {
        map.addAll({"name": name});
      }
      if (description != null) {
        map.addAll({"description": description});
      }
      if (photoCoverture != null) {
        map.addAll({"photo_coverture": photoCoverture});
      }
      if (latitude != null) {
        map.addAll({"latitude": latitude});
      }
      if (longitude != null) {
        map.addAll({"longitude": longitude});
      }
      if (villeId != null) {
        map.addAll({"ville_id": villeId});
      }
      if (photos != null) {
        map.addAll({"photos": photos});
      }
      await doc.update(map);
      Map<String, dynamic> json = (await doc.get()).data()!;
      json.addAll(successResponse);
      return RestaurantResponse.fromJson(json);
    } catch (e) {
      return RestaurantResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<RestaurantResponse> getRestaurant(String id) async {
    try {
      Map<String, dynamic> json =
          await _getElementParId(id, restaurantsCollection);
      return RestaurantResponse.fromJson(json);
    } catch (e) {
      return RestaurantResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<RestaurantsResponse> getRestaurantsParVille(String ville) async {
    try {
      final restaurantsList = await _getCollectionList(restaurantsCollection);
      List<Map<String, dynamic>> restaurantsParVilleList = [];
      for (var restaurant in restaurantsList) {
        if (restaurant["ville_id"] == ville) {
          restaurantsParVilleList.add(restaurant);
        }
      }
      final json = {
        "status": 0,
        "message": "SUCCESS",
        "restaurants": restaurantsParVilleList
      };
      return RestaurantsResponse.fromJson(json);
    } catch (e) {
      return RestaurantsResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<RestaurantsResponse> getRestaurantsParProprietaireId(
      String proprietaireId) async {
    try {
      final restaurantsList = await _getCollectionList(restaurantsCollection);
      List<Map<String, dynamic>> restaurantsParProprietaireIdList = [];
      for (var restaurant in restaurantsList) {
        if (restaurant["proprietaire_id"] == proprietaireId) {
          restaurantsParProprietaireIdList.add(restaurant);
        }
      }
      final json = {
        "status": 0,
        "message": "SUCCESS",
        "restaurants": restaurantsParProprietaireIdList
      };
      return RestaurantsResponse.fromJson(json);
    } catch (e) {
      return RestaurantsResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<DefaultResponse> deleteRestaurant(String id) {
    return _deleteElement(id, restaurantsCollection);
  }

  //Hebergment Section
  @override
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
      String proprietaireId) async {
    try {
      final collection = _firebaseStore.collection(hebergmentsCollection);
      final doc = collection.doc();
      Map<String, dynamic> json = {
        "id": doc.id,
        "name": name,
        "ville_id": villeId,
        "nbr_voyager": nbrVoyager,
        "nbr_place_disp": nbrPlaceDisp,
        "nbr_chambre_disp": nbrChambreDisp,
        "nbr_chambre_indiv": nbrChambreIndiv,
        "nbr_chambre_deux": nbrChambreDeux,
        "nbr_chambre_trois": nbrChambreTrois,
        "nbr_suit": nbrSuits,
        "prix_chambre_indiv": prixChambreIndiv,
        "prix_chambre_deux": prixChambreDeux,
        "prix_chambre_trois": prixChambreTrois,
        "prix_suit": prixSuits,
        "categorie": categorie,
        "description": description,
        "photo_coverture": photoCoverture,
        "latitude": latitude,
        "longitude": longitude,
        "photos": photos,
        "date_debut": dateDebut,
        "date_fin": Timestamp.fromDate(dateFin),
        "proprietaire_id": proprietaireId,
      };
      await doc.set(json);
      final response = (await doc.get()).data();
      response?.addAll(successResponse);
      HebergmentResponse hebergmentResponse =
          HebergmentResponse.fromJson(response!);
      return hebergmentResponse;
    } catch (e) {
      return HebergmentResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<HebergmentResponse> updatehebergment(String id,
      {String? name,
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
      DateTime? dateFin}) async {
    try {
      final collection = _firebaseStore.collection(hebergmentsCollection);
      final doc = collection.doc(id);
      Map<String, dynamic> map = {};
      if (name != null) {
        map.addAll({"name": name});
      }
      if (villeId != null) {
        map.addAll({"ville_id": villeId});
      }
      if (nbrVoyager != null) {
        map.addAll({"nbr_voyager": nbrVoyager});
      }
      if (nbrPlaceDisp != null) {
        map.addAll({"nbr_place_disp": nbrPlaceDisp});
      }
      if (nbrChambreDisp != null) {
        map.addAll({"nbr_chambre_disp": nbrChambreDisp});
      }
      if (nbrChambreIndiv != null) {
        map.addAll({"nbr_chambre_indiv": nbrChambreIndiv});
      }
      if (nbrChambreDeux != null) {
        map.addAll({"nbr_chambre_deux": nbrChambreDeux});
      }
      if (nbrChambreTrois != null) {
        map.addAll({"nbr_chambre_trois": nbrChambreTrois});
      }
      if (nbrSuits != null) {
        map.addAll({"nbr_suit": nbrSuits});
      }
      if (prixChambreIndiv != null) {
        map.addAll({"prix_chambre_disp": prixChambreIndiv});
      }
      if (prixChambreDeux != null) {
        map.addAll({"prix_chambre_deux": prixChambreDeux});
      }
      if (prixChambreTrois != null) {
        map.addAll({"prix_chambre_trois": prixChambreTrois});
      }
      if (prixSuit != null) {
        map.addAll({"prix_suit": prixSuit});
      }
      if (categorie != null) {
        map.addAll({"categorie": categorie});
      }
      if (latitude != null) {
        map.addAll({"latitude": latitude});
      }
      if (longitude != null) {
        map.addAll({"longitude": longitude});
      }
      if (photos != null) {
        map.addAll({"photos": photos});
      }
      if (photoCoverture != null) {
        map.addAll({"photo_coverture": photoCoverture});
      }
      if (description != null) {
        map.addAll({"description": description});
      }
      if (dateDebut != null) {
        map.addAll({"date_debut": dateDebut});
      }
      if (dateFin != null) {
        map.addAll({"date_fin": dateFin});
      }
      await doc.update(map);
      Map<String, dynamic> json = (await doc.get()).data() ?? {};
      if (json == {}) {
        return HebergmentResponse.fromJson({"status": 1, "message": "NO DATA"});
      }
      json.addAll(successResponse);
      return HebergmentResponse.fromJson(json);
    } catch (e) {
      return HebergmentResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<HebergmentsResponse> gethebergmentsParParametre(String ville,
      {DateTime? dateDebut,
      DateTime? dateFin,
      int? nbrPersonnes,
      String? categorie}) async {
    try {
      final hebergmentsList = await _getCollectionList(hebergmentsCollection);
      List<Map<String, dynamic>> hebergmentsParParametreList = [];
      for (var hebergment in hebergmentsList) {
        DateTime? dateDebutElement = _elementToDate(hebergment["date_debut"]);
        DateTime? dateFinElement = _elementToDate(hebergment["date_fin"]);
        if (dateDebutElement != null &&
            dateFinElement != null &&
            hebergment["ville_id"] != null &&
            hebergment["nbr_place_disp"] != null &&
            hebergment["categorie"] != null) {
          bool isInPeriod = true;
          if (dateDebut != null && dateFin != null) {
            isInPeriod = (!(dateDebut.isBefore(dateDebutElement)) &&
                !(dateFin.isAfter(dateFinElement)));
          }
          bool isPlacesAvailable = true;
          if (nbrPersonnes != null) {
            isPlacesAvailable = hebergment["nbr_place_disp"] >= nbrPersonnes;
          }
          bool isSameCategorie = true;
          if (categorie != null) {
            isSameCategorie = hebergment["categorie"] == categorie;
          }
          if (hebergment["ville_id"] == ville &&
              isSameCategorie &&
              isInPeriod &&
              isPlacesAvailable) {
            hebergmentsParParametreList.add(hebergment);
          }
        }
      }
      return HebergmentsResponse.fromJson({
        "status": 0,
        "message": "SUCCESS",
        "hebergments": hebergmentsParParametreList
      });
    } catch (e) {
      return HebergmentsResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<HebergmentResponse> getHebergment(String id) async {
    try {
      Map<String, dynamic> json =
          await _getElementParId(id, hebergmentsCollection);
      return HebergmentResponse.fromJson(json);
    } catch (e) {
      return HebergmentResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<HebergmentsResponse> getHebergmentsParProprietaireId(
      String proprietaireId) async {
    try {
      final hebergmentsList = await _getCollectionList(hebergmentsCollection);
      List<Map<String, dynamic>> hebergmentsParProprietaireIdList = [];
      for (var hebergment in hebergmentsList) {
        if (hebergment["proprietaire_id"] == proprietaireId) {
          hebergmentsParProprietaireIdList.add(hebergment);
        }
      }
      final json = {
        "status": 0,
        "message": "SUCCESS",
        "hebergments": hebergmentsParProprietaireIdList
      };
      return HebergmentsResponse.fromJson(json);
    } catch (e) {
      return HebergmentsResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<DefaultResponse> deleteHebergment(String id) {
    return _deleteElement(id, hebergmentsCollection);
  }

  //Reservation Section
  @override
  Future<ReservationResponse> postReservation(
      String userId,
      String proprietaireId,
      String type,
      String serviceId,
      int nbrPersonne,
      DateTime dateDebut,
      DateTime dateFin) async {
    try {
      final collection = _firebaseStore.collection(reservationsCollection);
      final doc = collection.doc();
      await doc.set({
        "id": doc.id,
        "user_id": userId,
        "type": type,
        "service_id": serviceId,
        "nbr_personne": nbrPersonne,
        "date_debut": dateDebut,
        "date_fin": dateFin,
        "proprietaire_id": proprietaireId
      });
      Map<String, dynamic>? json = (await doc.get()).data();
      if (json == null) {
        return ReservationResponse.fromJson(
            {"status": 1, "message": "DATA==NULL"});
      }
      json.addAll(successResponse);
      return ReservationResponse.fromJson(json);
    } catch (e) {
      return ReservationResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<ReservationResponse> updateReservation(String id, String type,
      [DateTime? dateDebut, DateTime? dateFin]) async {
    try {
      final collection = _firebaseStore.collection(reservationsCollection);
      final doc = collection.doc(id);
      Map<String, dynamic> map = {'type': type};
      if (dateDebut != null) {
        map.addAll({"date_debut": dateDebut});
      }
      if (dateFin != null) {
        map.addAll({"date_fin": dateFin});
      }
      await doc.update(map);

      Map<String, dynamic>? json = (await doc.get()).data();
      if (json == null) {
        return ReservationResponse.fromJson(
            {"status": 1, "message": "DATA==NULL"});
      }
      json.addAll(successResponse);
      return ReservationResponse.fromJson(json);
    } catch (e) {
      return ReservationResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<ReservationResponse> getReservation(String id) async {
    try {
      Map<String, dynamic> json =
          await _getElementParId(id, reservationsCollection);
      return ReservationResponse.fromJson(json);
    } catch (e) {
      return ReservationResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<ReservationsResponse> getReservationParParametre(
      {String? userId, String? proprietaireId, String? type}) async {
    try {
      final reservationsList = await _getCollectionList(reservationsCollection);
      List<Map<String, dynamic>> reservationsParParametreList = [];
      if ((userId == null && type != null) || proprietaireId == null) {
        for (var reservation in reservationsList) {
          if (reservation["user_id"] != null &&
              reservation["proprietaire_id"] != null &&
              reservation["type"] != null) {
            if ((userId == null || reservation["user_id"] == userId) &&
                (proprietaireId == null ||
                    reservation["proprietaire_id"] == proprietaireId) &&
                (type == null || reservation["type"] == type)) {
              reservationsParParametreList.add(reservation);
            }
          }
        }
      }
      return ReservationsResponse.fromJson({
        "status": 0,
        "message": "SUCCESS",
        "reservations": reservationsParParametreList
      });
    } catch (e) {
      return ReservationsResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<DefaultResponse> deleteReservation(String id) async {
    return await _deleteElement(id, reservationsCollection);
  }

  //Pack Section
  @override
  Future<DefaultResponse> deletePack(String id) async {
    return await _deleteElement(id, packsCollection);
  }

  @override
  Future<PackResponse> getPack(String id) async {
    try {
      Map<String, dynamic> json = await _getElementParId(id, packsCollection);
      return PackResponse.fromJson(json);
    } catch (e) {
      return PackResponse.fromJson({"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<PacksResponse> getPacksParParametre(String ville,
      {DateTime? dateDebut, DateTime? dateFin, int? nbrPersonnes}) async {
    try {
      final packsList = await _getCollectionList(packsCollection);
      List<Map<String, dynamic>> packsParParametreList = [];
      for (var pack in packsList) {
        DateTime? dateDebutElement = _elementToDate(pack["date_debut"]);
        DateTime? dateFinElement = _elementToDate(pack["date_fin"]);
        if (dateDebutElement != null &&
            dateFinElement != null &&
            pack["villes_id"] != null &&
            pack["nbr_plce_disp"] != null) {
          bool isInPeriod = true;
          if (dateDebut != null && dateFin != null) {
            isInPeriod = (!(dateDebut.isBefore(dateDebutElement)) &&
                !(dateFin.isAfter(dateFinElement)));
          }
          bool isPlacesAvailable = true;
          if (nbrPersonnes != null) {
            isPlacesAvailable = pack["nbr_plce_disp"] >= nbrPersonnes;
          }
          bool isSameVille = false;
          for (String villeId in pack["villes_id"]) {
            if (villeId == ville) {
              isSameVille = true;
            }
          }
          if (isSameVille && isInPeriod && isPlacesAvailable) {
            packsParParametreList.add(pack);
          }
        }
      }
      return PacksResponse.fromJson(
          {"status": 0, "message": "SUCCESS", "packs": packsParParametreList});
    } catch (e) {
      return PacksResponse.fromJson({"status": 2, "message": e.toString()});
    }
  }

  @override
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
      String proprietaireId) async {
    try {
      final collection = _firebaseStore.collection(packsCollection);
      final doc = collection.doc();
      await doc.set({
        "id": doc.id,
        "name": name,
        "description": description,
        "photo_coverture": photoCoverture,
        "photos": photos,
        "villes_id": villesId,
        "activites": activites,
        "hebergments": hebergments,
        "restaurants": restaurants,
        "nbr_place": nbrPlace,
        "nbr_plce_disp": nbrPlaceDisp,
        "date_debut": dateDebut,
        "date_fin": dateFin,
        "prix": prix,
        "proprietaire_id": proprietaireId
      });
      Map<String, dynamic>? json = (await doc.get()).data();
      if (json == null) {
        return PackResponse.fromJson({"status": 1, "message": "DATA==NULL"});
      }
      json.addAll(successResponse);
      return PackResponse.fromJson(json);
    } catch (e) {
      return PackResponse.fromJson({"status": 2, "message": e.toString()});
    }
  }

  @override
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
  }) async {
    try {
      final collection = _firebaseStore.collection(packsCollection);
      final doc = collection.doc(id);
      Map<String, dynamic> map = {};
      if (name != null) {
        map.addAll({"name": name});
      }
      if (villesId != null) {
        map.addAll({"villes_id": villesId});
      }
      if (nbrPlace != null) {
        map.addAll({"nbr_place": nbrPlace});
      }
      if (nbrPlaceDisp != null) {
        map.addAll({"nbr_plce_disp": nbrPlaceDisp});
      }
      if (prix != null) {
        map.addAll({"prix": prix});
      }
      if (activites != null) {
        map.addAll({"activites": activites});
      }
      if (hebergments != null) {
        map.addAll({"hebergments": hebergments});
      }
      if (restaurants != null) {
        map.addAll({"restaurants": restaurants});
      }
      if (photos != null) {
        map.addAll({"photos": photos});
      }
      if (photoCoverture != null) {
        map.addAll({"photo_coverture": photoCoverture});
      }
      if (description != null) {
        map.addAll({"description": description});
      }
      if (dateDebut != null) {
        map.addAll({"date_debut": dateDebut});
      }
      if (dateFin != null) {
        map.addAll({"date_fin": dateFin});
      }
      await doc.update(map);
      Map<String, dynamic> json = (await doc.get()).data() ?? {};
      if (json == {}) {
        return PackResponse.fromJson({"status": 1, "message": "NO DATA"});
      }
      json.addAll(successResponse);
      return PackResponse.fromJson(json);
    } catch (e) {
      return PackResponse.fromJson({"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<PacksResponse> getPacksParProprietaireId(String proprietaireId) async {
    try {
      final packsList = await _getCollectionList(packsCollection);
      List<Map<String, dynamic>> packsParProprietaireIdList = [];
      for (var pack in packsList) {
        if (pack["proprietaire_id"] == proprietaireId) {
          packsParProprietaireIdList.add(pack);
        }
      }
      final json = {
        "status": 0,
        "message": "SUCCESS",
        "packs": packsParProprietaireIdList
      };
      return PacksResponse.fromJson(json);
    } catch (e) {
      return PacksResponse.fromJson({"status": 2, "message": e.toString()});
    }
  }

  //Image Section
  @override
  Future<ImageResponse> storeImage(XFile imageFile) async {
    try {
      final storageRef = _firebaseStorage.ref();
      final imagesRef = storageRef.child(imagesFolder);
      final fileRef = imagesRef.child(imageFile.name);
      final upload = await fileRef.putFile(File(imageFile.path));
      if (upload.state == TaskState.success) {
        final downloadURL = await fileRef.getDownloadURL();
        return ImageResponse.fromJson(
            {"status": 0, "message": "SUCCESS", "image_url": downloadURL});
      } else {
        return ImageResponse.fromJson(
            {"status": 1, "message": upload.state.name});
      }
    } catch (e) {
      return ImageResponse.fromJson({"status": 2, "message": e.toString()});
    }
  }

  @override
  Future<DefaultResponse> deleteImage(String imageUrl) async {
    try {
      final storageRef = _firebaseStorage.ref();
      final imagesRef = storageRef.child(imagesFolder);
      final fileRef = imagesRef.child(_imageNameFromUrl(imageUrl));
      await fileRef.delete();
      return DefaultResponse.fromJson(successResponse);
    } catch (e) {
      return DefaultResponse.fromJson({"status": 2, "message": e.toString()});
    }
  }

  //Private Functions Section
  Future<Map<String, dynamic>> _getElementParId(
      String id, String collectionName) async {
    try {
      final collectionRef = _firebaseStore.collection(collectionName);
      final doc = collectionRef.doc(id);
      Map<String, dynamic>? data = (await doc.get()).data();
      if (data != null) {
        data.addAll(successResponse);
      } else {
        return ({"status": 1, "message": "DATA==NULL"});
      }
      return data;
    } catch (e) {
      return ({"status": 2, "message": e.toString()});
    }
  }

  Future<DefaultResponse> _deleteElement(
      String id, String collectionName) async {
    try {
      final collectionRef = _firebaseStore.collection(collectionName);
      final doc = collectionRef.doc(id);
      (await doc.delete());
      return DefaultResponse.fromJson(successResponse);
    } catch (e) {
      return DefaultResponse.fromJson({"status": 2, "message": e.toString()});
    }
  }

  Future<AuthenticationResponse> _postUser(
      String email,
      String firstName,
      String lastName,
      String villeId,
      String userType,
      String phone,
      String civilite,
      String photo,
      double points) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await _firebaseStore.collection(userCollection).doc(user.uid).set({
          "id": user.uid,
          'fisrt_name': firstName,
          'last_name': lastName,
          'user_type': userType,
          'villeId': villeId,
          'civilite': civilite,
          'photo': photo,
          'points': points,
          'phone': phone,
          'email': email,
        });
        return AuthenticationResponse.fromJson({
          "status": 0,
          "message": "SUCCESS",
          "id": user.uid,
          'fisrt_name': firstName,
          'last_name': lastName,
          'user_type': userType,
          'villeId': villeId,
          'civilite': civilite,
          'photo': photo,
          'points': points,
          'phone': phone,
          'email': email,
        });
      } else {
        return AuthenticationResponse.fromJson(
            {"status": 1, "message": "USER==NULL"});
      }
    } catch (e) {
      return AuthenticationResponse.fromJson(
          {"status": 2, "message": e.toString()});
    }
  }

  Future<List<Map<String, dynamic>>> _getCollectionList(
      String collectionName) async {
    final collection = _firebaseStore.collection(collectionName);
    final data = (await collection.get()).docs;
    List<Map<String, dynamic>> list = [];
    for (var element in data) {
      list.add(element.data());
    }
    return list;
  }

  DateTime? _elementToDate(dynamic element) {
    try {
      final date = ((element as Timestamp).toDate());
      return date;
    } catch (_) {
      return null;
    }
  }

  String _imageNameFromUrl(String imageUrl) {
    int startPoint = imageUrl.indexOf("images%2F") + 9;
    int endPoint = imageUrl.indexOf("?alt=media");
    String result = imageUrl.substring(startPoint, endPoint);
    return result;
  }
}
