import 'package:agence_voyage/app/di.dart';
import 'package:flutter/material.dart';
import 'package:agence_voyage/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...
void main() async {
  //WidgetsFlutterBinding fi main kif tabda fama async await
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initAppModule();
  runApp(MyApp());
}
