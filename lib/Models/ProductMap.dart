// // To parse this JSON data, do
// //
// //     final productMap = productMapFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'ecommercemodels.dart';
//
// List<ProductMap> productMapFromJson(String str) => List<ProductMap>.from(json.decode(str).map((x) => ProductMap.fromJson(x)));
//
// String productMapToJson(List<ProductMap> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class ProductMap {
//   ProductMap({
//     this.productid,
//     this.value,
//   });
//
//   int? productid;
//   Value? value;
//
//   factory ProductMap.fromJson(Map<String, dynamic> json) => ProductMap(
//     productid: json["productid"],
//     value: Value.fromJson(json["value"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "productid": productid,
//     "value": value?.toJson(),
//   };
// }
//
//
// To parse this JSON data, do
//
//     final productMap = productMapFromMap(jsonString);

import 'dart:convert';

List<ProductMap> productMapFromMap(String str) => List<ProductMap>.from(json.decode(str).map((x) => ProductMap.fromMap(x)));

String productMapToMap(List<ProductMap> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ProductMap {
  ProductMap({
    this.productid,
    this.product,
  });

  int? productid;
  Product? product;

  factory ProductMap.fromMap(Map<String, dynamic> json) => ProductMap(
    productid: json["productid"],
    product: Product.fromMap(json["product"]),
  );

  Map<String, dynamic> toMap() => {
    "productid": productid,
    "product": product?.toMap(),
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.imageUrl,
    this.bannerUrl,
    this.image,
    this.actualPrice,
    this.offerPrice,
    this.offer,
    this.isExpress,
  });

  int? id;
  String? name;
  dynamic imageUrl;
  dynamic bannerUrl;
  String? image;
  String? actualPrice;
  String? offerPrice;
  int? offer;
  bool? isExpress;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    imageUrl: json["image_url"],
    bannerUrl: json["banner_url"],
    image: json["image"],
    actualPrice: json["actual_price"],
    offerPrice: json["offer_price"],
    offer: json["offer"],
    isExpress: json["is_express"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "image_url": imageUrl,
    "banner_url": bannerUrl,
    "image": image,
    "actual_price": actualPrice,
    "offer_price": offerPrice,
    "offer": offer,
    "is_express": isExpress,
  };
}
