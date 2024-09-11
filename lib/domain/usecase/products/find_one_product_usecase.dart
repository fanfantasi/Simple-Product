
import 'package:klontong/data/model/products_model.dart';
import 'package:klontong/domain/repositories/repository.dart';

class FindOneProductUseCase {
  final Repository repository;

  FindOneProductUseCase({required this.repository});
  Future<ResultProductsModel> call({String? params}) async {
    return await repository.getFindOneProduct(params: params);
  }
}
