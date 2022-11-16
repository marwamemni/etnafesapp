// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LoginObjectTearOff {
  const _$LoginObjectTearOff();

  _LoginObject call(String userName, String password) {
    return _LoginObject(
      userName,
      password,
    );
  }
}

/// @nodoc
const $LoginObject = _$LoginObjectTearOff();

/// @nodoc
mixin _$LoginObject {
  String get userName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res>;
  $Res call({String userName, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res> implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  final LoginObject _value;
  // ignore: unused_field
  final $Res Function(LoginObject) _then;

  @override
  $Res call({
    Object? userName = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$LoginObjectCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$LoginObjectCopyWith(
          _LoginObject value, $Res Function(_LoginObject) then) =
      __$LoginObjectCopyWithImpl<$Res>;
  @override
  $Res call({String userName, String password});
}

/// @nodoc
class __$LoginObjectCopyWithImpl<$Res> extends _$LoginObjectCopyWithImpl<$Res>
    implements _$LoginObjectCopyWith<$Res> {
  __$LoginObjectCopyWithImpl(
      _LoginObject _value, $Res Function(_LoginObject) _then)
      : super(_value, (v) => _then(v as _LoginObject));

  @override
  _LoginObject get _value => super._value as _LoginObject;

  @override
  $Res call({
    Object? userName = freezed,
    Object? password = freezed,
  }) {
    return _then(_LoginObject(
      userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginObject implements _LoginObject {
  _$_LoginObject(this.userName, this.password);

  @override
  final String userName;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(userName: $userName, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginObject &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.password, password));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(password));

  @JsonKey(ignore: true)
  @override
  _$LoginObjectCopyWith<_LoginObject> get copyWith =>
      __$LoginObjectCopyWithImpl<_LoginObject>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(String userName, String password) = _$_LoginObject;

  @override
  String get userName;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$LoginObjectCopyWith<_LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$RegisterObjectTearOff {
  const _$RegisterObjectTearOff();

  _RegisterObject call(
      String email,
      String password,
      String firstName,
      String lastName,
      String villeId,
      String userType,
      String phone,
      String civilite,
      String photo,
      double points) {
    return _RegisterObject(
      email,
      password,
      firstName,
      lastName,
      villeId,
      userType,
      phone,
      civilite,
      photo,
      points,
    );
  }
}

/// @nodoc
const $RegisterObject = _$RegisterObjectTearOff();

/// @nodoc
mixin _$RegisterObject {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get villeId => throw _privateConstructorUsedError;
  String get userType => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get civilite => throw _privateConstructorUsedError;
  String get photo => throw _privateConstructorUsedError;
  double get points => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterObjectCopyWith<RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterObjectCopyWith<$Res> {
  factory $RegisterObjectCopyWith(
          RegisterObject value, $Res Function(RegisterObject) then) =
      _$RegisterObjectCopyWithImpl<$Res>;
  $Res call(
      {String email,
      String password,
      String firstName,
      String lastName,
      String villeId,
      String userType,
      String phone,
      String civilite,
      String photo,
      double points});
}

/// @nodoc
class _$RegisterObjectCopyWithImpl<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  _$RegisterObjectCopyWithImpl(this._value, this._then);

  final RegisterObject _value;
  // ignore: unused_field
  final $Res Function(RegisterObject) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? villeId = freezed,
    Object? userType = freezed,
    Object? phone = freezed,
    Object? civilite = freezed,
    Object? photo = freezed,
    Object? points = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      villeId: villeId == freezed
          ? _value.villeId
          : villeId // ignore: cast_nullable_to_non_nullable
              as String,
      userType: userType == freezed
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      civilite: civilite == freezed
          ? _value.civilite
          : civilite // ignore: cast_nullable_to_non_nullable
              as String,
      photo: photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String,
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$RegisterObjectCopyWith<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  factory _$RegisterObjectCopyWith(
          _RegisterObject value, $Res Function(_RegisterObject) then) =
      __$RegisterObjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {String email,
      String password,
      String firstName,
      String lastName,
      String villeId,
      String userType,
      String phone,
      String civilite,
      String photo,
      double points});
}

/// @nodoc
class __$RegisterObjectCopyWithImpl<$Res>
    extends _$RegisterObjectCopyWithImpl<$Res>
    implements _$RegisterObjectCopyWith<$Res> {
  __$RegisterObjectCopyWithImpl(
      _RegisterObject _value, $Res Function(_RegisterObject) _then)
      : super(_value, (v) => _then(v as _RegisterObject));

  @override
  _RegisterObject get _value => super._value as _RegisterObject;

  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? villeId = freezed,
    Object? userType = freezed,
    Object? phone = freezed,
    Object? civilite = freezed,
    Object? photo = freezed,
    Object? points = freezed,
  }) {
    return _then(_RegisterObject(
      email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      villeId == freezed
          ? _value.villeId
          : villeId // ignore: cast_nullable_to_non_nullable
              as String,
      userType == freezed
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      civilite == freezed
          ? _value.civilite
          : civilite // ignore: cast_nullable_to_non_nullable
              as String,
      photo == freezed
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String,
      points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_RegisterObject implements _RegisterObject {
  _$_RegisterObject(
      this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.villeId,
      this.userType,
      this.phone,
      this.civilite,
      this.photo,
      this.points);

  @override
  final String email;
  @override
  final String password;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String villeId;
  @override
  final String userType;
  @override
  final String phone;
  @override
  final String civilite;
  @override
  final String photo;
  @override
  final double points;

  @override
  String toString() {
    return 'RegisterObject(email: $email, password: $password, firstName: $firstName, lastName: $lastName, villeId: $villeId, userType: $userType, phone: $phone, civilite: $civilite, photo: $photo, points: $points)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegisterObject &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality().equals(other.firstName, firstName) &&
            const DeepCollectionEquality().equals(other.lastName, lastName) &&
            const DeepCollectionEquality().equals(other.villeId, villeId) &&
            const DeepCollectionEquality().equals(other.userType, userType) &&
            const DeepCollectionEquality().equals(other.phone, phone) &&
            const DeepCollectionEquality().equals(other.civilite, civilite) &&
            const DeepCollectionEquality().equals(other.photo, photo) &&
            const DeepCollectionEquality().equals(other.points, points));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(firstName),
      const DeepCollectionEquality().hash(lastName),
      const DeepCollectionEquality().hash(villeId),
      const DeepCollectionEquality().hash(userType),
      const DeepCollectionEquality().hash(phone),
      const DeepCollectionEquality().hash(civilite),
      const DeepCollectionEquality().hash(photo),
      const DeepCollectionEquality().hash(points));

  @JsonKey(ignore: true)
  @override
  _$RegisterObjectCopyWith<_RegisterObject> get copyWith =>
      __$RegisterObjectCopyWithImpl<_RegisterObject>(this, _$identity);
}

abstract class _RegisterObject implements RegisterObject {
  factory _RegisterObject(
      String email,
      String password,
      String firstName,
      String lastName,
      String villeId,
      String userType,
      String phone,
      String civilite,
      String photo,
      double points) = _$_RegisterObject;

  @override
  String get email;
  @override
  String get password;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get villeId;
  @override
  String get userType;
  @override
  String get phone;
  @override
  String get civilite;
  @override
  String get photo;
  @override
  double get points;
  @override
  @JsonKey(ignore: true)
  _$RegisterObjectCopyWith<_RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}
