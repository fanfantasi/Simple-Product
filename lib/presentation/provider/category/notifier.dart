
import 'package:flutter/material.dart';
import 'package:klontong/domain/entities/categories_entity.dart';
import 'package:klontong/domain/usecase/category/get_category_usecase.dart';
import 'package:klontong/presentation/pages/products/widgets/categories.dart';

class CategoryNotifier extends ChangeNotifier {
  final GetCategoryUseCase getCategoryUseCase;
  CategoryNotifier({required this.getCategoryUseCase});


  bool _isloading = false;
  bool get isloading => _isloading;
  set isloading(bool val){
    _isloading = val;
    notifyListeners();
  }

  ResultCategoryEntity? _categorySelected;
  ResultCategoryEntity? get categorySelected => _categorySelected;
  set categorySelected(ResultCategoryEntity? val){
    _categorySelected = val;
    notifyListeners();
  }

  List<ResultCategoryEntity> _categories = [];
  List<ResultCategoryEntity> get categories => _categories;
  set categories(List<ResultCategoryEntity> val){
    _categories = val;
    notifyListeners();
  }

  Future<void> getCategories() async {
    isloading = false;
    try{
      var res = await getCategoryUseCase.call(params: '');
      if (res.error == null){
        isloading = false;
        categories = res.data??[];
      }else{
        isloading = false;
      }
    }catch(_){
      isloading = false;
    }
  }

  void showButtomSheetCategories(BuildContext context) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const CategoriesWidget();
      });
  }
  
}