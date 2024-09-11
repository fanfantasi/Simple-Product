import 'package:klontong/domain/entities/categories_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel.fromJSON(Map<String, dynamic> json)
      : super(
          error: json['error'],
          message: json['message'],
          data: json['data'] != null
              ? List.from(json['data'])
                  .map((e) => ResultCategoryModel.fromJSON(e))
                  .toList()
              : null,
        );

  Map<String, dynamic> toJson() => {
        'error':error,
        'message':message,
        'data': data,
      };
}

class ResultCategoryModel extends ResultCategoryEntity {
  ResultCategoryModel.fromJSON(Map<String, dynamic> json)
  :super (
    id: json['id'],
    name: json['name']
  );
}
