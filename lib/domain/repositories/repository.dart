

import 'package:klontong/data/model/index.dart';

abstract class Repository {
  Future<ProductModel> getProduct({String? params});
  Future<CategoryModel> getCategory({String? params});
  Future<ResultProductsModel> getFindOneProduct({String? params});
  Future<ResponseModel> createProduct({Map? map});
}