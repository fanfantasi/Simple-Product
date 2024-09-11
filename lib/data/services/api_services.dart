import 'package:dio/dio.dart';
import 'package:klontong/core/config/config.dart';
import 'package:klontong/data/model/index.dart';
import 'logging_interceptors.dart';

class ApiService {
  Dio get dio => _dio();
  Dio _dio() {
    final options = BaseOptions(
      baseUrl: Configs.baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 10000),
      contentType: "application/json;charset=utf-8",
      validateStatus: (_) => true,
    );

    var dio = Dio(options);

    dio.interceptors.add(LoggingInterceptors());
    return dio;
  }

  Future<ProductModel> getProduct({String? params}) async {
    try{
      Response response = await dio.get('product$params',);
      return ProductModel.fromJSON(response.data);
    }catch(error, stacktrace){
      throw Exception("Exception occurred: $error stackTrace: $stacktrace");
    }
  }

  Future<ResultProductsModel> getFindOneProduct({String? params}) async {
    try{
      Response response = await dio.post('product/findone',
        data: {
          'id': params
        }
      );
      return ResultProductsModel.fromJSON(response.data['data']);
    }catch(error, stacktrace){
      throw Exception("Exception occurred: $error stackTrace: $stacktrace");
    }
  }

  Future<ResponseModel> upsertProduct({Map? map}) async {
    try{
      FormData? formData;
      if (map?['image'] == '' || map?['image'] == null){
        formData = FormData.fromMap({
          'category': map?['category'],
          'sku': map?['sku'],
          'name': map?['name'],
          'description': map?['description'],
          'weight': map?['weight'],
          'width': map?['width'],
          'length': map?['length'],
          'height': map?['height'],
          'price': map?['price'],
        });
      }else{
        formData = FormData.fromMap({
          'category': map?['category'],
          'sku': map?['sku'],
          'name': map?['name'],
          'description': map?['description'],
          'weight': map?['weight'],
          'width': map?['width'],
          'length': map?['length'],
          'height': map?['height'],
          'price': map?['price'],
          'image': await MultipartFile.fromFile(map?['image'], filename: map?['image'].split('/').last)
        });
      }
      Response response = await dio.post('product',
        data: formData
      );
      return ResponseModel.fromJSON(response.data);
    }catch(error, stacktrace){
      throw Exception("Exception occurred: $error stackTrace: $stacktrace");
    }
  }

  Future<CategoryModel> getCategory({String? params}) async {
    try{
      Response response = await dio.get('category$params',);
      return CategoryModel.fromJSON(response.data);
    }catch(error, stacktrace){
      throw Exception("Exception occurred: $error stackTrace: $stacktrace");
    }
  }

}
