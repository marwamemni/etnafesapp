// ignore_for_file: hash_and_equals

enum UserType {
  visiteur,
  voyageur,
  adminAgence,
  prorietereResto,
  prorietereHeberg
}

enum Civilite { marie, celibataire }

class Authentication {
  String id;
  String firstName;
  String lastName;
  String userType;
  String villeId;
  String civilite;
  String photo;
  double points;
  String phone;
  String email;

  Authentication(
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
}

class Paye {
  String id;
  int code;
  String name;
  Paye(this.id, this.code, this.name);

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    Paye otherPaye = other as Paye;
    return id == otherPaye.id;
  }
}

class Ville {
  String id;
  String name;
  String photo;
  String payeId;

  Ville(
    this.id,
    this.name,
    this.photo,
    this.payeId,
  );

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    Ville otherPaye = other as Ville;
    return id == otherPaye.id;
  }
}

class Restaurant {
  String id;
  String name;
  String description;
  String photoCoverture;
  String villeId;
  double latitude;
  double longitude;
  List<String> photos;
  String proprietaireId;
  Restaurant(
      this.id,
      this.name,
      this.description,
      this.photoCoverture,
      this.villeId,
      this.latitude,
      this.longitude,
      this.photos,
      this.proprietaireId);
}

class Hebergment {
  String id;
  String name;
  String villeId;
  int nbrVoyager;
  int nbrPlaceDisp;
  int nbrChambreDisp;
  int nbrChambreIndiv;
  int nbrChambreDeux;
  int nbrChambreTrois;
  int nbrSuit;
  double prixChambreIndiv;
  double prixChambreDeux;
  double prixChambreTrois;
  double prixSuit;
  String categorie;
  String description;
  String photoCoverture;
  double latitude;
  double longitude;
  List<String> photos;
  DateTime dateDebut;
  DateTime dateFin;
  String proprietaireId;
  Hebergment(
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
}

class Reservation {
  String id;
  String userId;
  String proprietaireId;
  String type;
  String serviceId;
  int nbrPersonne;
  DateTime dateDebut;
  DateTime dateFin;
  Reservation(this.id, this.userId, this.proprietaireId, this.type,
      this.serviceId, this.nbrPersonne, this.dateDebut, this.dateFin);
}

class Pack {
  String id;
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
  String proprietaireId;
  double prix;
  Pack(
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
}

class ElementId {
  String id;
  ElementId(this.id);
}
