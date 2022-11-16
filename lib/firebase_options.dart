// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCjdzDdGgotiSLcprJ4DtE0BK4paDd-6oc',
    appId: '1:757651482082:web:82f9a19badcbc241d9c5bb',
    messagingSenderId: '757651482082',
    projectId: 'agence-de-voyage-b4763',
    authDomain: 'agence-de-voyage-b4763.firebaseapp.com',
    storageBucket: 'agence-de-voyage-b4763.appspot.com',
    measurementId: 'G-5JJPBY6B4M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1cslifIZzmSbtLnconpTU5Fm8tHpY9io',
    appId: '1:757651482082:android:98057d1628fe6c04d9c5bb',
    messagingSenderId: '757651482082',
    projectId: 'agence-de-voyage-b4763',
    storageBucket: 'agence-de-voyage-b4763.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKkY_048PyhJfuC7a3cMhCSRp1tZL8cWY',
    appId: '1:757651482082:ios:2bac2d1e8aade571d9c5bb',
    messagingSenderId: '757651482082',
    projectId: 'agence-de-voyage-b4763',
    storageBucket: 'agence-de-voyage-b4763.appspot.com',
    iosClientId: '757651482082-dhkcd1mu70k0dbdck39qqu59r0f9l2hi.apps.googleusercontent.com',
    iosBundleId: 'com.example.agenceVoyage',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAKkY_048PyhJfuC7a3cMhCSRp1tZL8cWY',
    appId: '1:757651482082:ios:2bac2d1e8aade571d9c5bb',
    messagingSenderId: '757651482082',
    projectId: 'agence-de-voyage-b4763',
    storageBucket: 'agence-de-voyage-b4763.appspot.com',
    iosClientId: '757651482082-dhkcd1mu70k0dbdck39qqu59r0f9l2hi.apps.googleusercontent.com',
    iosBundleId: 'com.example.agenceVoyage',
  );
}
