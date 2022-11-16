import 'package:agence_voyage/app/app_prefs.dart';
import 'package:agence_voyage/data/data_source/remote_data_source.dart';
import 'package:agence_voyage/data/network/app_api.dart';
import 'package:agence_voyage/data/network/app_api_imp.dart';
import 'package:agence_voyage/data/network/network_info.dart';
import 'package:agence_voyage/data/repository/repository_impl.dart';
import 'package:agence_voyage/domain/model/models.dart';
import 'package:agence_voyage/domain/repository/repository.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/getUser_usecase.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/logout_usecase.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/update_profil_usecase.dart';
import 'package:agence_voyage/domain/usecase/hebergments%20use%20cases/delete_hebergment_usecase.dart';
import 'package:agence_voyage/domain/usecase/hebergments%20use%20cases/get_hebergment_usercase.dart';
import 'package:agence_voyage/domain/usecase/hebergments%20use%20cases/get_hebergments_par_parametres_usease.dart';
import 'package:agence_voyage/domain/usecase/hebergments%20use%20cases/get_hebergments_par_prorietere_id.dart';
import 'package:agence_voyage/domain/usecase/hebergments%20use%20cases/post_hebergment_usecase.dart';
import 'package:agence_voyage/domain/usecase/images%20use%20cases/delete_image_usecase.dart';
import 'package:agence_voyage/domain/usecase/images%20use%20cases/store_image_usecase.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/login_usecase.dart';
import 'package:agence_voyage/domain/usecase/authentication%20use%20cases/register_usecase.dart';
import 'package:agence_voyage/domain/usecase/packages%20use%20cases/get_pack_usecase.dart';
import 'package:agence_voyage/domain/usecase/packages%20use%20cases/get_packages_par_parametres_usease.dart';
import 'package:agence_voyage/domain/usecase/packages%20use%20cases/update_pack_usecase.dart';
import 'package:agence_voyage/domain/usecase/reservations%20use%20cases/get_user_reservation_usecase.dart';
import 'package:agence_voyage/domain/usecase/reservations%20use%20cases/post_reservation.dart';
import 'package:agence_voyage/domain/usecase/restaurants%20use%20cases/delete_restaurant_usecase.dart';
import 'package:agence_voyage/domain/usecase/restaurants%20use%20cases/get_restaurant_par_proprieter_id_usecase.dart';
import 'package:agence_voyage/domain/usecase/restaurants%20use%20cases/get_restaurant_usecase.dart';
import 'package:agence_voyage/domain/usecase/restaurants%20use%20cases/post_restaurant_usecase.dart';
import 'package:agence_voyage/domain/usecase/restaurants%20use%20cases/update_restaurant_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_pays_usecase.dart';
import 'package:agence_voyage/domain/usecase/ville%20use%20cases/get_villes_usecase.dart';
import 'package:agence_voyage/presentation/add_hebergment/viewmodel/add_hebergment_viewmodel.dart';
import 'package:agence_voyage/presentation/edit%20restaurant/viewmodel/edit_restaurant_viewmodel.dart';
import 'package:agence_voyage/presentation/edit_hebergement/viewmodel/edit_hebergement_viewmodel.dart';
import 'package:agence_voyage/presentation/hebergments_voyager/viewmodel/hebergments_voyageur_viewmodel.dart';
import 'package:agence_voyage/presentation/home%20proprietere%20restaurant/view_model/home_P_restaux_viewmodel.dart';
import 'package:agence_voyage/presentation/home_admin/view_model/home_admin_viewmodel.dart';
import 'package:agence_voyage/presentation/home_heberger/view_model/home_heberger_viewmodel.dart';
import 'package:agence_voyage/presentation/home_voyageur/viewmodel/home_viewmodel.dart';
import 'package:agence_voyage/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:agence_voyage/presentation/notfication%20voyageur/view%20model/notification_voyageur_viewmodel.dart';
import 'package:agence_voyage/presentation/pack_details.dart/view_model/pack_viewmodel.dart';
import 'package:agence_voyage/presentation/profil/profil_viewmodel/profil_viewmodel.dart';
import 'package:agence_voyage/presentation/register/view_model/register_viewmodel.dart';
import 'package:agence_voyage/presentation/restaurant_details/view_model/restaurant_details_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/usecase/authentication use cases/forgot_password_usecase.dart';
import '../domain/usecase/hebergments use cases/update_hebergment_usecase.dart';
import '../domain/usecase/packages use cases/delete_pack_usecase.dart';
import '../domain/usecase/packages use cases/get_packs_par_propietere_id_usecase.dart';
import '../domain/usecase/packages use cases/post_pack_usecase.dart';
import '../domain/usecase/reservations use cases/update_reservatiom_usecase.dart';
import '../domain/usecase/restaurants use cases/get_restaurants_par_parametres_usease.dart';
import '../presentation/add restaurant/viewmodel/add_restaurant_viewmodel.dart';
import '../presentation/add_pack/viewmodel/add_pack_viewmodel.dart';
import '../presentation/edit_pack/viewmodel/edit_pack_viewmodel.dart';
import '../presentation/hebergments_details/hebergments_details_viewmodel/hebergments_details_viewmodel.dart';
import '../presentation/packs_voyager.dart/viewmodel/packs_voyageur_viewmodel.dart';
import '../presentation/restaurants_voyager/viewmodel/restaurants_voyageur_viewmodel.dart';

final instance = GetIt.instance;
bool isAppNotInitialized = true;
Future<void> initAppModule() async {
  isAppNotInitialized = false;
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(() {
    return AppPreferences(instance<SharedPreferences>());
  });

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClientImp());

  // remote data source
  instance
      .registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());

  // repository

  instance.registerLazySingleton<Repository>(() => RepositoryImpl());

  //FireAuth
  instance.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  //FireStore
  instance.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  //FireStorage
  instance
      .registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  //GetPaysUseCase
  instance
      .registerLazySingleton<GetPaysUseCase>(() => GetPaysUseCase(instance()));

  //GetVillesUseCase
  instance.registerLazySingleton<GetVillesUseCase>(
      () => GetVillesUseCase(instance()));

  //StoreImageUseCase
  instance.registerLazySingleton<StoreImageUseCase>(
      () => StoreImageUseCase(instance()));

  //DeleteImageUseCase
  instance.registerLazySingleton<DeleteImageUseCase>(
      () => DeleteImageUseCase(instance()));

  //resetUser
  resetUser();

  //GethebergmentUseCase
  instance.registerFactory<GethebergmentUseCase>(
      () => GethebergmentUseCase(instance()));

  //PostReservatonUseCase
  instance.registerFactory<PostReservatonUseCase>(
      () => PostReservatonUseCase(instance()));

  //UpdateProfilUseCase
  instance.registerFactory<UpdateProfilUseCase>(
      () => UpdateProfilUseCase(instance()));

  //UpdatehebergmentUseCase
  instance.registerFactory<UpdatehebergmentUseCase>(
      () => UpdatehebergmentUseCase(instance()));

  //GetUserUseCase
  instance.registerFactory<GetUserUseCase>(() => GetUserUseCase(instance()));

  //ImagePicker
  instance.registerFactory<ImagePicker>(() => ImagePicker());

  //GetRestaurantUseCase
  instance.registerFactory<GetRestaurantUseCase>(
      () => GetRestaurantUseCase(instance()));

  //GetPackUseCase
  instance.registerFactory<GetPackUseCase>(() => GetPackUseCase(instance()));

  //UpDatePackUseCase
  instance
      .registerFactory<UpDatePackUseCase>(() => UpDatePackUseCase(instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<LoginViewModel>(
        () => LoginViewModel(instance(), instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeViewModel>()) {
    instance.registerFactory<HomeViewModel>(() => HomeViewModel());
  }
}

initUser(Authentication authentication) {
  user = authentication;
}

Authentication user =
    Authentication("", "", "", UserType.visiteur.name, "", "", "", 0, "", "");
resetUser() {
  user =
      Authentication("", "", "", UserType.visiteur.name, "", "", "", 0, "", "");
}

initNotificationVoyageurModule() {
  if (!GetIt.I.isRegistered<NotificationVoyageurViewModel>()) {
    instance.registerFactory<NotificationVoyageurViewModel>(
        () => NotificationVoyageurViewModel());
    instance.registerFactory<GetUserReservatonUseCase>(
        () => GetUserReservatonUseCase(instance()));
    instance.registerFactory<UpdateReservationUseCase>(
        () => UpdateReservationUseCase(instance()));
  }
}

initProfilModule() {
  if (!GetIt.I.isRegistered<ProfilViewModel>()) {
    instance
        .registerFactory<ProfilViewModel>(() => ProfilViewModel(instance()));
    instance.registerFactory<LogoutUseCase>(() => LogoutUseCase(instance()));
  }
}

initHebergmentsVoyageurModule() {
  if (!GetIt.I.isRegistered<HebergmentsVoyageurViewModel>()) {
    instance.registerFactory<HebergmentsVoyageurViewModel>(
        () => HebergmentsVoyageurViewModel());
    instance.registerFactory<GethebergmentsParParametreUseCase>(
        () => GethebergmentsParParametreUseCase(instance()));
  }
}

initPacksVoyageurModule() {
  if (!GetIt.I.isRegistered<PacksVoyageurViewModel>()) {
    instance.registerFactory<PacksVoyageurViewModel>(
        () => PacksVoyageurViewModel());
    instance.registerFactory<GetPacksParParametreUseCase>(
        () => GetPacksParParametreUseCase(instance()));
  }
}

initRestaurantsVoyageurModule() {
  if (!GetIt.I.isRegistered<RestaurantsVoyageurViewModel>()) {
    instance.registerFactory<RestaurantsVoyageurViewModel>(
        () => RestaurantsVoyageurViewModel());
    instance.registerFactory<GetRestaurantsParParametreUseCase>(
        () => GetRestaurantsParParametreUseCase(instance()));
  }
}

initHebergmentModule() {
  if (!GetIt.I.isRegistered<HebergmentDetailsViewModel>()) {
    instance.registerFactory<HebergmentDetailsViewModel>(
        () => HebergmentDetailsViewModel());
  }
}

initRestaurantModule() {
  if (!GetIt.I.isRegistered<RestaurantDetailsViewModel>()) {
    instance.registerFactory<RestaurantDetailsViewModel>(
        () => RestaurantDetailsViewModel());
  }
}

initPackModule() {
  if (!GetIt.I.isRegistered<PackDetailsViewModel>()) {
    instance
        .registerFactory<PackDetailsViewModel>(() => PackDetailsViewModel());
  }
}

initHomeHebergerModule() {
  if (!GetIt.I.isRegistered<HomeHebergerViewModel>()) {
    instance
        .registerFactory<HomeHebergerViewModel>(() => HomeHebergerViewModel());
    instance.registerFactory<GethebergmentsParProprietaireUseCase>(
        () => GethebergmentsParProprietaireUseCase(instance()));
    instance.registerFactory<DeletehebergmentUseCase>(
        () => DeletehebergmentUseCase(instance()));
  }
}

initAddHebergementModule() {
  if (!GetIt.I.isRegistered<AddHebergmentViewModel>()) {
    instance.registerFactory<AddHebergmentViewModel>(
        () => AddHebergmentViewModel());
    instance.registerFactory<PosthebergmentUseCase>(
        () => PosthebergmentUseCase(instance()));
  }
}

initEditHebergementModule() {
  if (!GetIt.I.isRegistered<EditHebergmentViewModel>()) {
    instance.registerFactory<EditHebergmentViewModel>(
        () => EditHebergmentViewModel());
  }
}

initHomeAdminModule() {
  if (!GetIt.I.isRegistered<HomeAdminViewModel>()) {
    instance.registerFactory<HomeAdminViewModel>(() => HomeAdminViewModel());
    instance.registerFactory<GetPacksParProrietereIdUseCase>(
        () => GetPacksParProrietereIdUseCase(instance()));
    instance.registerFactory<DeletePackUseCase>(
        () => DeletePackUseCase(instance()));
  }
}

initAddPackModule() {
  if (!GetIt.I.isRegistered<AddPackViewModel>()) {
    instance.registerFactory<AddPackViewModel>(() => AddPackViewModel());
    instance
        .registerFactory<PostPackUseCase>(() => PostPackUseCase(instance()));
  }
}

initEditPackModule() {
  if (!GetIt.I.isRegistered<EditPackViewModel>()) {
    instance.registerFactory<EditPackViewModel>(() => EditPackViewModel());
  }
}

initHomeProprietereRestauxModule() {
  if (!GetIt.I.isRegistered<HomePRestauxViewModel>()) {
    instance
        .registerFactory<HomePRestauxViewModel>(() => HomePRestauxViewModel());
    instance.registerFactory<GetRestaurantsParProprietereIdUseCase>(
        () => GetRestaurantsParProprietereIdUseCase(instance()));
    instance.registerFactory<DeleteRestaurantUseCase>(
        () => DeleteRestaurantUseCase(instance()));
  }
}

initAddRestaurantModule() {
  if (!GetIt.I.isRegistered<AddRestaurantViewModel>()) {
    instance.registerFactory<AddRestaurantViewModel>(
        () => AddRestaurantViewModel());
    instance.registerFactory<PostRestaurantUseCase>(
        () => PostRestaurantUseCase(instance()));
  }
}

initEditRestaurantModule() {
  if (!GetIt.I.isRegistered<EditRestaurantViewModel>()) {
    instance.registerFactory<EditRestaurantViewModel>(
        () => EditRestaurantViewModel());
    instance.registerFactory<UpdateRestaurantUseCase>(
        () => UpdateRestaurantUseCase(instance()));
  }
}
