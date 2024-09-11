class CategoryEntity {
  final String? error;
  final String? message;
  final List<ResultCategoryEntity>? data;
  const CategoryEntity({this.data, this.error, this.message});
}


class ResultCategoryEntity {
  final String? id;
  final String? name;
  ResultCategoryEntity({
    this.id, 
    this.name
  });
}
