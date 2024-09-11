
import 'package:klontong/data/model/index.dart';
import 'package:klontong/domain/repositories/repository.dart';

class UpsertProductUseCase {
  final Repository repository;

  UpsertProductUseCase({required this.repository});
  Future<ResponseModel> call({Map? map}) async {
    return await repository.createProduct(map: map);
  }
}
