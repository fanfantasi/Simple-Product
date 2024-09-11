class ProductEntity {
  final String? error;
  final String? message;
  final List<ResultProductsEntity>? data;
  const ProductEntity({this.data, this.error, this.message});
}


class ResultProductsEntity {
  final String? id;
  final ResultCategoryProductEntity? category;
  final String? sku;
  final String? name;
  final String? description;
  final int? weight;
  final int? width;
  final int? length;
  final int? height;
  final String? image;
  final int? price;
  ResultProductsEntity({
    this.id, 
    this.category,
    this.sku, 
    this.name, 
    this.description,
    this.weight, 
    this.width,
    this.length,
    this.height,
    this.image,
    this.price});
}

class ResultCategoryProductEntity {
  final String? id;
  final String? name;
  ResultCategoryProductEntity({
    this.id, 
    this.name, 
  });
}
