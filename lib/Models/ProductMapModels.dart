// // To parse this JSON data, do
// //     final ProductMapModels = ProductMapModelsFromJson(jsonString);
import 'dart:convert';

import 'ecommercemodels.dart';

List<ProductMapModels> productMapModelsFromMap(String str) =>
    List<ProductMapModels>.from(json.decode(str).map((x) => ProductMapModels.fromjson(x)));

String productMapModelsToMap(List<ProductMapModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductMapModels {
  ProductMapModels({
    this.productTableId,
    this.product,
     this.quantityCount
  });

  int? productTableId;
  Value? product;
 int? quantityCount;

  factory ProductMapModels.fromjson(Map<String, dynamic> json) => ProductMapModels(
        productTableId: json["productsTableId"],
        product: Value.fromJson(jsonDecode(json["product"])),
    quantityCount: json["productCount"],
      );

  Map<String, dynamic> toJson() => {
        "productsTableId": productTableId,
        "product": product?.toJson(),
    "productCount": quantityCount,
      };
}


