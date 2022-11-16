import 'package:agence_voyage/data/network/failure.dart';
import 'package:agence_voyage/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../repository/repository.dart';

class StoreImageUseCase implements BaseUseCase<XFile, String> {
  final Repository _repository;

  StoreImageUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(XFile input) async {
    return await _repository.storeImage(input);
  }
}
