// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
    String email,
    String password,
    String firstName,
    String lastName,
    String villeId,
    String userType,
    String phone,
    String civilite,
    String photo,
    double points,
  ) = _RegisterObject;
}
