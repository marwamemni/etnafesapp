import '../../app/constants.dart';
import '../../domain/model/models.dart';
import '../response/responses.dart';
import 'package:agence_voyage/app/extensions.dart';

extension DefaultResponseMapper on DefaultResponse? {
  bool toDomain() {
    return (this?.status ?? 1) == 0;
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.id.orEmpty() ?? Constants.empty,
      this?.firstName.orEmpty() ?? Constants.empty,
      this?.lastName.orEmpty() ?? Constants.empty,
      this?.userType.orEmpty() ?? Constants.empty,
      this?.villeId.orEmpty() ?? Constants.empty,
      this?.civilite.orEmpty() ?? Constants.empty,
      this?.photo.orEmpty() ?? Constants.empty,
      this?.points.orZero() ?? Constants.zeroD,
      this?.phone.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
    );
  }
}

extension PayeResponseMapper on PayeResponse? {
  Paye toDomain() {
    return Paye(
        this?.id.orEmpty() ?? Constants.empty,
        this?.code.orZero() ?? Constants.zero,
        this?.name.orEmpty() ?? Constants.empty);
  }
}

extension PaysResponseMapper on PaysResponse? {
  List<Paye> toDomain() {
    return (this?.pays?.map((payeResponse) => payeResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Paye>()
        .toList();
  }
}

extension VilleResponseMapper on VilleResponse? {
  Ville toDomain() {
    return Ville(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.photo.orEmpty() ?? Constants.empty,
        this?.payeId.orEmpty() ?? Constants.empty);
  }
}

extension VillesResponseMapper on VillesResponse? {
  List<Ville> toDomain() {
    return (this?.villes?.map((villeResponse) => villeResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Ville>()
        .toList();
  }
}

extension RestaurantResponseMapper on RestaurantDataResponse? {
  Restaurant toDomain() {
    final List<String> photos =
        this?.photos?.map((photo) => photo.orEmpty()).toList() ??
            const Iterable.empty().cast<String>().toList();
    return Restaurant(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.description.orEmpty() ?? Constants.empty,
        this?.photoCoverture.orEmpty() ?? Constants.empty,
        this?.villeId.orEmpty() ?? Constants.empty,
        this?.latitude.orZero() ?? Constants.zeroD,
        this?.longitude.orZero() ?? Constants.zeroD,
        photos,
        this?.proprietaireId.orEmpty() ?? Constants.empty);
  }
}

extension RestaurantsResponseMapper on RestaurantsResponse? {
  List<Restaurant> toDomain() {
    return (this
                ?.restaurants
                ?.map((restaurantResponse) => restaurantResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Restaurant>()
        .toList();
  }
}

extension HebergmentDataResponseMapper on HebergmentDataResponse? {
  Hebergment toDomain() {
    final List<String> photos =
        this?.photos?.map((photo) => photo.orEmpty()).toList() ??
            const Iterable.empty().cast<String>().toList();
    return Hebergment(
      this?.id.orEmpty() ?? Constants.empty,
      this?.name.orEmpty() ?? Constants.empty,
      this?.villeId.orEmpty() ?? Constants.empty,
      this?.nbrVoyager.orZero() ?? Constants.zero,
      this?.nbrPlaceDisp.orZero() ?? Constants.zero,
      this?.nbrChambreDisp.orZero() ?? Constants.zero,
      this?.nbrChambreIndiv.orZero() ?? Constants.zero,
      this?.nbrChambreDeux.orZero() ?? Constants.zero,
      this?.nbrChambreTrois.orZero() ?? Constants.zero,
      this?.nbrSuit.orZero() ?? Constants.zero,
      this?.prixChambreIndiv.orZero() ?? Constants.zeroD,
      this?.prixChambreDeux.orZero() ?? Constants.zeroD,
      this?.prixChambreTrois.orZero() ?? Constants.zeroD,
      this?.prixSuit.orZero() ?? Constants.zeroD,
      this?.categorie.orEmpty() ?? Constants.empty,
      this?.description.orEmpty() ?? Constants.empty,
      this?.photoCoverture.orEmpty() ?? Constants.empty,
      this?.latitude.orZero() ?? Constants.zeroD,
      this?.longitude.orZero() ?? Constants.zeroD,
      photos,
      this?.dateDebut.orEmpty() ?? Constants.dateTime,
      this?.dateFin.orEmpty() ?? Constants.dateTime,
      this?.proprietaireId.orEmpty() ?? Constants.empty,
    );
  }
}

extension HebergmentsMapper on HebergmentsResponse? {
  List<Hebergment> toDomain() {
    return (this
                ?.hebergments
                ?.map((hebergmentResponse) => hebergmentResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Hebergment>()
        .toList();
  }
}

extension ReservationDataResponseMapper on ReservationDataResponse? {
  Reservation toDomain() {
    return Reservation(
      this?.id.orEmpty() ?? Constants.empty,
      this?.userId.orEmpty() ?? Constants.empty,
      this?.proprietaireId.orEmpty() ?? Constants.empty,
      this?.type.orEmpty() ?? Constants.empty,
      this?.serviceId.orEmpty() ?? Constants.empty,
      this?.nbrPersonne.orZero() ?? Constants.zero,
      this?.dateDebut.orEmpty() ?? Constants.dateTime,
      this?.dateFin.orEmpty() ?? Constants.dateTime,
    );
  }
}

extension ReservationsMapper on ReservationsResponse? {
  List<Reservation> toDomain() {
    return (this?.reservations?.map(
                (reservationResponse) => reservationResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Reservation>()
        .toList();
  }
}

extension PackDataResponseMapper on PackDataResponse? {
  Pack toDomain() {
    final List<String> photos =
        this?.photos?.map((photo) => photo.orEmpty()).toList() ??
            const Iterable.empty().cast<String>().toList();

    final List<String> villesId =
        this?.villesId?.map((villeId) => villeId.orEmpty()).toList() ??
            const Iterable.empty().cast<String>().toList();

    final List<String> activites =
        this?.activites?.map((activite) => activite.orEmpty()).toList() ??
            const Iterable.empty().cast<String>().toList();
    final List<String> hebergments =
        this?.hebergments?.map((hebergment) => hebergment.orEmpty()).toList() ??
            const Iterable.empty().cast<String>().toList();

    final List<String> restaurants =
        this?.restaurants?.map((restaurant) => restaurant.orEmpty()).toList() ??
            const Iterable.empty().cast<String>().toList();
    return Pack(
      this?.id.orEmpty() ?? Constants.empty,
      this?.name.orEmpty() ?? Constants.empty,
      this?.description.orEmpty() ?? Constants.empty,
      this?.photoCoverture.orEmpty() ?? Constants.empty,
      photos,
      villesId,
      activites,
      hebergments,
      restaurants,
      this?.nbrPlace.orZero() ?? Constants.zero,
      this?.nbrPlaceDisp.orZero() ?? Constants.zero,
      this?.dateDebut.orEmpty() ?? Constants.dateTime,
      this?.dateFin.orEmpty() ?? Constants.dateTime,
      this?.proprietaireId.orEmpty() ?? Constants.empty,
      this?.prix.orZero() ?? Constants.zeroD,
    );
  }
}

extension PacksResponseMapper on PacksResponse? {
  List<Pack> toDomain() {
    return (this?.packs?.map((packResponse) => packResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Pack>()
        .toList();
  }
}

extension ImageResponseMapper on ImageResponse? {
  String toDomain() {
    return this?.imageUrl.orEmpty() ?? Constants.empty;
  }
}
