import 'dart:convert';

import 'package:shopping/scr/models/brands_model.dart';

List<BrandsAppleDataModel> brandsAppleFromJson(String str) =>
    List<BrandsAppleDataModel>.from(
        json.decode(str).map((x) => BrandsAppleDataModel.fromMap(x)));

String brandsAppleToJson(List<BrandsAppleDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class BrandsAppleDataModel implements BrandDataModel {
  final int id;
  final String name;
  final String image;
  final int price;
  final Brand brand;

  BrandsAppleDataModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.brand,
  });

  factory BrandsAppleDataModel.fromMap(Map<String, dynamic> json) =>
      BrandsAppleDataModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        brand: brandValues.map[json["brand"]]!,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "brand": brandValues.reverse[brand],
      };
}

enum Brand { APPLE }

final brandValues = EnumValues({"Apple": Brand.APPLE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
