// ignore_for_file: constant_identifier_names

import 'package:agence_voyage/data/network/failure.dart';

Failure getFailure(int? code) {
  switch (code) {
    case ResponseCode.DEFAULT:
      return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    case ResponseCode.NO_INTERNET:
      return Failure(
          ResponseCode.NO_INTERNET, ResponseMessage.NO_INTERNET_CONNECTION);
    case ResponseCode.SUCCESS:
      return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);

    case ResponseCode.SERVER_FAILURE:
      return Failure(
          ResponseCode.SERVER_FAILURE, ResponseMessage.SERVER_FAILURE);

    case ResponseCode.INTERNAL_FAILURE:
      return Failure(
          ResponseCode.INTERNAL_FAILURE, ResponseMessage.INTERNAL_FAILURE);
    default:
      return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
  }
}

class ResponseCode {
  static const int DEFAULT = -2;
  static const int NO_INTERNET = -1;
  static const int SUCCESS = 0;
  static const int SERVER_FAILURE = 1;
  static const int INTERNAL_FAILURE = 2;
}

class ResponseMessage {
  static const String DEFAULT = 'default error';
  static const String NO_INTERNET_CONNECTION = 'no internet error';
  static const String SUCCESS = 'success'; // success with data
  static const String SERVER_FAILURE = 'server failure';
  static const String INTERNAL_FAILURE = 'internal failure';
}
