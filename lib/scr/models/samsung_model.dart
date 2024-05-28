import 'dart:convert';

import 'package:shopping/scr/models/brands_model.dart';

List<BrandsSamsungDataModel> brandsSamsungDataModelFromJson(String str) =>
    List<BrandsSamsungDataModel>.from(
        json.decode(str).map((x) => BrandsSamsungDataModel.fromMap(x)));

String brandsSamsungDataModelToJson(List<BrandsSamsungDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class BrandsSamsungDataModel implements BrandDataModel {
  final int id;
  final String name;
  final String image;
  final int price;
  final String brand;

  BrandsSamsungDataModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.brand,
  });

  factory BrandsSamsungDataModel.fromMap(Map<String, dynamic> json) =>
      BrandsSamsungDataModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        brand: json["brand"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "brand": brand,
      };
}
