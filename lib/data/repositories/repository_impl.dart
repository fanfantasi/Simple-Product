import 'package:klontong/data/model/index.dart';
import 'package:klontong/domain/repositories/repository.dart';

import '../datasource/datasource.dart';

class RepositoryImpl implements Repository {
  final DataSource dataSource;

  RepositoryImpl({required this.dataSource});
  
  @override
  Future<ProductModel> getProduct({String? params}) async => dataSource.getProduct(params: params);

  @override
  Future<CategoryModel> getCategory({String? params}) async => dataSource.getCategory(params: params);

  @override
  Future<ResultProductsModel> getFindOneProduct({String? params}) async => dataSource.getFindOneProduct(params: params);

  @override
  Future<ResponseModel> createProduct({Map? map}) async => dataSource.createProduct(map: map);
}