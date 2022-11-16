// ignore_for_file: constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  //login
  //_sharedPreferences pour enregister les key
  // accepter les type primere (bool ; string)
  // en general il y a 4 fct (get set remove , cleal)
  // get tekhdh key w trajaalna valeur si nn null ken mafmch enregistrement l valeur
  // set tekdh key w valeur matrjaa chy mais taaml enregi ll key
  // remove tfaskh valeur
  // clear tfasakh kol chy

  Future<void> setUserLoggedIn(String id) async {
    _sharedPreferences.setString(PREFS_KEY_IS_USER_LOGGED_IN, id);
  }

  // ? return string or null
  Future<String?> isUserLoggedIn() async {
    return _sharedPreferences.getString(PREFS_KEY_IS_USER_LOGGED_IN);
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }
}
