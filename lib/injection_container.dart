import 'package:get_it/get_it.dart';
import 'package:klontong/domain/repositories/repository.dart';
import 'package:klontong/domain/usecase/category/get_category_usecase.dart';
import 'package:klontong/domain/usecase/products/find_one_product_usecase.dart';
import 'package:klontong/domain/usecase/products/get_product_usecase.dart';
import 'package:klontong/domain/usecase/products/upsert_product_usecase.dart';
import 'package:klontong/presentation/provider/category/notifier.dart';

import 'data/datasource/datasource.dart';
import 'data/datasource/datasource_impl.dart';
import 'data/repositories/repository_impl.dart';
import 'data/services/api_services.dart';
import 'presentation/provider/product/notifier.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory<ProductNotifier>(() => ProductNotifier(
    getProductUseCase: getIt.call(), 
    upsertProductUseCase: getIt.call(),
    findOneProductUseCase: getIt.call()
    ),
  );

  getIt.registerFactory<CategoryNotifier>(() => CategoryNotifier(
    getCategoryUseCase: getIt.call()
    ),
  );
  

  getIt.registerLazySingleton<GetProductUseCase>(() => GetProductUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<FindOneProductUseCase>(() => FindOneProductUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<UpsertProductUseCase>(() => UpsertProductUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<GetCategoryUseCase>(() => GetCategoryUseCase(repository: getIt.call()));
  
  //repository
  getIt.registerLazySingleton<Repository>(
      () => RepositoryImpl(dataSource: getIt.call()));

  //remote data
  getIt.registerLazySingleton<DataSource>(
      () => DataSourceImpl(api: getIt.call()));

  //External
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  
}