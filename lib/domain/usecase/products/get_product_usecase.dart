
import 'package:klontong/data/model/products_model.dart';
import 'package:klontong/domain/repositories/repository.dart';

class GetProductUseCase {
  final Repository repository;

  GetProductUseCase({required this.repository});
  Future<ProductModel> call({String? params}) async {
    return await repository.getProduct(params: params);
  }
}
