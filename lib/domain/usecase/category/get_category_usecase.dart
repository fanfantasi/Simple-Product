
import 'package:klontong/data/model/index.dart';
import 'package:klontong/domain/repositories/repository.dart';

class GetCategoryUseCase {
  final Repository repository;

  GetCategoryUseCase({required this.repository});
  Future<CategoryModel> call({String? params}) async {
    return await repository.getCategory(params: params);
  }
}
