import 'package:klontong/domain/entities/products_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel.fromJSON(Map<String, dynamic> json)
      : super(
          error: json['error'],
          message: json['message'],
          data: json['data'] != null
              ? List.from(json['data'])
                  .map((e) => ResultProductsModel.fromJSON(e))
                  .toList()
              : null,
        );

  Map<String, dynamic> toJson() => {
        'error':error,
        'message':message,
        'data': data,
      };
}

class ResultProductsModel extends ResultProductsEntity {
  ResultProductsModel.fromJSON(Map<String, dynamic> json)
  :super (
    id: json['id'],
    category: ResultCategoryProduct.fromJSON(json['category']),
    sku: json['sku'],
    name: json['name'],
    description: json['description'],
    weight: json['weight'],
    width: json['width'],
    length: json['length'],
    height: json['height'],
    image: json['image'],
    price: json['price'],
  );
}

class ResultCategoryProduct extends ResultCategoryProductEntity {
  ResultCategoryProduct.fromJSON(Map<String, dynamic> json)
  :super (
    id: json['id'],
    name: json['name'],
  );
}