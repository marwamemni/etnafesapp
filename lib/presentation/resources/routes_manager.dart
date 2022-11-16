import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/presentation/add%20restaurant/view/add_restaurant_view.dart';
import 'package:agence_voyage/presentation/add_hebergment/view/add_hebergment_view.dart';
import 'package:agence_voyage/presentation/edit%20restaurant/view/edit_restaurant_view.dart';
import 'package:agence_voyage/presentation/edit_hebergement/view/edit_hebergement_view.dart';
import 'package:agence_voyage/presentation/edit_pack/view/edit_pack_view.dart';
import 'package:agence_voyage/presentation/hebergments_details/hebergments_details_view/hebergments_details_view.dart';
import 'package:agence_voyage/presentation/hebergments_voyager/view/hebergments_voyageur_view.dart';
import 'package:agence_voyage/presentation/home%20proprietere%20restaurant/view/home_P_restaux_view.dart';
import 'package:agence_voyage/presentation/home_admin/view/home_admin_view.dart';
import 'package:agence_voyage/presentation/home_heberger/view/home_heberger_view.dart';
import 'package:agence_voyage/presentation/home_voyageur/view/home_view.dart';
import 'package:agence_voyage/presentation/login/view/login_view.dart';
import 'package:agence_voyage/presentation/notfication%20voyageur/view/notification_view.dart';
import 'package:agence_voyage/presentation/pack_details.dart/view/pack_view.dart';
import 'package:agence_voyage/presentation/profil/profil_view/profil_view.dart';
import 'package:agence_voyage/presentation/register/view/register_view.dart';
import 'package:agence_voyage/presentation/restaurant_details/view/restaurant_details_view.dart';
import 'package:agence_voyage/presentation/restaurants_voyager/view/restaurants_voyageur_view.dart';
import 'package:agence_voyage/presentation/splash/splash_view.dart';
import 'package:flutter/material.dart';
import '../../app/di.dart';
import '../add_pack/view/add_pack_view.dart';
import '../packs_voyager.dart/view/packs_voyageur_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String onBoardingRoute = "/onBoarding";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String notificationRoute = "/notification";
  static const String profilRoute = "/profil";
  static const String reservationRoute = "/reservation";

  static const String hebergmentVoyageurRoute = "/hebergmentVoyageur";
  static const String packsVoyageurRoute = "/PacksVoyageur";
  static const String restaurantsVoyageurRoute = "/RestaurantsVoyageur";

  static const String hebergmentDetailsRoute = "/hebergmentDetails";
  static const String packsDetailsRoute = "/PacksDetails";
  static const String restaurantsDetailsRoute = "/RestaurantsDetails";

  static const String homeHebergerRoute = '/homeHebergerRoute';
  static const String homeAdminRoute = '/homeAdminRoute';
  static const String homeProprieterRestauRoute = '/homeProprieterRestauRoute';

  static const String editHebergementRoute = '/editHebergementRoute';
  static const String addHebergementRoute = '/addHebergementRoute';

  static const String editAdminRoute = '/editAdminRoute';
  static const String addAdminRoute = '/addAdminRoute';

  static const String editRestaurantRoute = '/editRestaurantRoute';
  static const String addRestaurantRoute = '/addRestaurantRoute';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.notificationRoute:
        initNotificationVoyageurModule();
        return MaterialPageRoute(
            builder: (_) => const NotificationVoyageurView());
      case Routes.profilRoute:
        initRegisterModule();
        initProfilModule();
        return MaterialPageRoute(builder: (_) => const ProfilView());
      case Routes.hebergmentVoyageurRoute:
        initHebergmentsVoyageurModule();
        return MaterialPageRoute(
            builder: (_) => const HebergmentVoyageurView());
      case Routes.packsVoyageurRoute:
        initPacksVoyageurModule();
        return MaterialPageRoute(builder: (_) => const PacksVoyageurView());
      case Routes.restaurantsVoyageurRoute:
        initRestaurantsVoyageurModule();
        return MaterialPageRoute(
            builder: (_) => const RestaurantsVoyageurView());
      case Routes.hebergmentDetailsRoute:
        initHebergmentModule();
        return MaterialPageRoute(
            builder: (_) => HebergmentDetailsView(
                  id: (settings.arguments as ElementId).id,
                ));
      case Routes.restaurantsDetailsRoute:
        initRestaurantModule();
        return MaterialPageRoute(
            builder: (_) => RestaurantDetailsView(
                  id: (settings.arguments as ElementId).id,
                ));
      case Routes.packsDetailsRoute:
        initPackModule();
        return MaterialPageRoute(
            builder: (_) => PackDetailsView(
                  id: (settings.arguments as ElementId).id,
                ));
      case Routes.homeHebergerRoute:
        initHomeHebergerModule();
        return MaterialPageRoute(builder: (_) => const HomeHebergerView());
      case Routes.addHebergementRoute:
        initAddHebergementModule();
        return MaterialPageRoute(builder: (_) => const AddHebergementView());
      case Routes.editHebergementRoute:
        initEditHebergementModule();
        return MaterialPageRoute(
            builder: (_) => EditHebergmentView(
                  id: (settings.arguments as ElementId).id,
                ));
      case Routes.homeAdminRoute:
        initHomeAdminModule();
        return MaterialPageRoute(builder: (_) => const HomeAdminView());
      case Routes.addAdminRoute:
        initAddPackModule();
        return MaterialPageRoute(builder: (_) => const AddPackView());
      case Routes.editAdminRoute:
        initEditPackModule();
        return MaterialPageRoute(
            builder: (_) => EditPackView(
                  id: (settings.arguments as ElementId).id,
                ));
      case Routes.homeProprieterRestauRoute:
        initHomeProprietereRestauxModule();
        return MaterialPageRoute(builder: (_) => const HomePRestauxView());
      case Routes.addRestaurantRoute:
        initAddRestaurantModule();
        return MaterialPageRoute(builder: (_) => const AddRestaurantView());
      case Routes.editRestaurantRoute:
        initEditRestaurantModule();
        return MaterialPageRoute(
            builder: (_) => EditRestaurantView(
                  id: (settings.arguments as ElementId).id,
                ));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('no Route Found'),
              ),
              body: const Center(child: Text('no Route Found')),
            ));
  }
}
