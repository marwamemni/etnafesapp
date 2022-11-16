import 'package:agence_voyage/app/di.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/repository/repository.dart';
import 'package:agence_voyage/presentation/common/common%20widgets/loading_widget.dart';
import 'package:agence_voyage/presentation/resources/color_manager.dart';
import 'package:agence_voyage/presentation/resources/font_manager.dart';
import 'package:agence_voyage/presentation/resources/styles_manager.dart';
import 'package:agence_voyage/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

Widget getNotification(Reservation reservation, void Function() onPressed) {
  return TextButton(
    onPressed: onPressed,
    child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white.withOpacity(AppOpacity.o087),
          borderRadius: BorderRadius.circular(AppSize.s15),
          border: Border.all(color: ColorManager.vert),
        ),
        margin: const EdgeInsets.all(15),
        child: _getNotificationBody(reservation)),
  );
}

Widget _getNotificationBody(Reservation reservation) {
  final Repository repository = instance<Repository>();
  if (reservation.type.startsWith("r")) {
    return FutureBuilder<Restaurant?>(
        future: _getRestaurant(repository, reservation),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return loadingWidget();
          }
          return user.userType == UserType.voyageur.name
              ? _getNotificationBodyUi(snapShot.data!.photoCoverture,
                  snapShot.data!.name, reservation.type)
              : _getProprietereNotificationBodyUi(
                  snapShot.data!.photoCoverture,
                  snapShot.data!.name,
                  reservation.dateDebut,
                  reservation.dateFin,
                  reservation.nbrPersonne);
        });
  } else if (reservation.type.startsWith("h")) {
    return FutureBuilder<Hebergment?>(
        future: _getHebergment(repository, reservation),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return loadingWidget();
          }
          return user.userType == UserType.voyageur.name
              ? _getNotificationBodyUi(snapShot.data!.photoCoverture,
                  snapShot.data!.name, reservation.type)
              : _getProprietereNotificationBodyUi(
                  snapShot.data!.photoCoverture,
                  snapShot.data!.name,
                  reservation.dateDebut,
                  reservation.dateFin,
                  reservation.nbrPersonne);
        });
  } else if (reservation.type.startsWith("p")) {
    return FutureBuilder<Pack?>(
        future: _getPack(repository, reservation),
        builder: (context, snapShot) {
          if (!snapShot.hasData) return loadingWidget();
          return user.userType == UserType.voyageur.name
              ? _getNotificationBodyUi(snapShot.data!.photoCoverture,
                  snapShot.data!.name, reservation.type)
              : _getProprietereNotificationBodyUi(
                  snapShot.data!.photoCoverture,
                  snapShot.data!.name,
                  reservation.dateDebut,
                  reservation.dateFin,
                  reservation.nbrPersonne);
        });
  } else {
    return const Text("error");
  }
}

Widget _getNotificationBodyUi(String src, String title, String type) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s15),
          child: Image.network(
            src,
            fit: BoxFit.fill,
            height: AppSize.s100,
          )),
      Expanded(
        child: SizedBox(
          height: AppSize.s100,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppPadding.p4),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s15),
                    border: Border.all(color: ColorManager.grey),
                  ),
                  child: Text(
                    title,
                    style: getRegularStyle(
                        fontFamily: FontConstants.swiss721Family,
                        fontSize: FontSize.s15,
                        color: ColorManager.grey),
                  ),
                ),
                Text(
                  (type.contains("2")) ? "Validé" : "Au cours de traitement",
                  style: getRegularStyle(
                      fontFamily: FontConstants.swiss721Family,
                      fontSize: FontSize.s15,
                      color: ColorManager.vert),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}

Widget _getProprietereNotificationBodyUi(String src, String title,
    DateTime dateDebut, DateTime dateFin, int nbrPersonne) {
  return Stack(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s15),
                child: Image.network(
                  src,
                  fit: BoxFit.fill,
                  height: AppSize.s100,
                )),
          ),
          Expanded(
            child: SizedBox(
              height: AppSize.s100,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppPadding.p4),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s15),
                        border: Border.all(color: ColorManager.grey),
                      ),
                      child: Text(
                        title,
                        style: getRegularStyle(
                            fontFamily: FontConstants.swiss721Family,
                            fontSize: FontSize.s15,
                            color: ColorManager.grey),
                      ),
                    ),
                    Text(
                      'De ${dateDebut.year}/${dateDebut.month}/${dateDebut.day}',
                      style: getRegularStyle(
                          fontFamily: FontConstants.swiss721Family,
                          fontSize: FontSize.s15,
                          color: ColorManager.vert),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      (user.userType == UserType.prorietereResto.name)
                          ? '${dateFin.hour}:${dateFin.minute}H'
                          : 'A ${dateFin.year}/${dateFin.month}/${dateFin.day}',
                      style: getRegularStyle(
                          fontFamily: FontConstants.swiss721Family,
                          fontSize: FontSize.s15,
                          color: ColorManager.vert),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: AppSize.s15,
          )
        ],
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: CircleAvatar(
            maxRadius: AppSize.s15,
            backgroundColor: ColorManager.grey,
            foregroundColor: ColorManager.white,
            child: Text(nbrPersonne.toString())),
      )
    ],
  );
}

Future<Restaurant?> _getRestaurant(
    Repository repository, Reservation reservation) async {
  Restaurant? restaurant;
  (await repository.getRestaurant(reservation.serviceId)).fold((l) {}, (r) {
    return restaurant = r;
  });
  return restaurant;
}

Future<Hebergment?> _getHebergment(
    Repository repository, Reservation reservation) async {
  Hebergment? hebergment;
  (await repository.getHebergment(reservation.serviceId)).fold((l) {}, (r) {
    return hebergment = r;
  });
  return hebergment;
}

Future<Pack?> _getPack(Repository repository, Reservation reservation) async {
  Pack? pack;
  (await repository.getPack(reservation.serviceId)).fold((l) {}, (r) {
    return pack = r;
  });
  return pack;
}
