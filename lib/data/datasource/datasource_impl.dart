

import 'package:klontong/data/model/index.dart';
import '../services/api_services.dart';
import 'datasource.dart';

class DataSourceImpl implements DataSource {
  final ApiService api;
  DataSourceImpl({required this.api});

  @override
  Future<ProductModel> getProduct({String? params}) async => api.getProduct(params: params);

  @override
  Future<CategoryModel> getCategory({String? params}) async => api.getCategory(params: params);

  @override
  Future<ResultProductsModel> getFindOneProduct({String? params}) async => api.getFindOneProduct(params: params);

  @override
  Future<ResponseModel> createProduct({Map? map}) async => api.upsertProduct(map: map);
}