import 'dart:convert';
import 'dart:developer';

import 'package:shopping/scr/models/apple_model.dart';
import 'package:shopping/scr/models/brands_model.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/scr/models/samsung_model.dart';

class BrandServices {
  static Future<List<BransDataModel>> fetchData() async {
    var client = http.Client();
    List<BransDataModel> posts = [];
    try {
      var response = await client.get(Uri.parse(
          'https://asia-northeast1-wc2022-bot.cloudfunctions.net/brands'));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        BransDataModel post =
            BransDataModel.fromMap(result[i] as Map<String, dynamic>);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}

class BrandAppleServices {
  static Future<List<BrandsAppleDataModel>> fetchData() async {
    var client = http.Client();
    List<BrandsAppleDataModel> apple = [];
    try {
      var response = await client.get(Uri.parse(
          'https://asia-northeast1-wc2022-bot.cloudfunctions.net/products?brand=apple'));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        BrandsAppleDataModel post =
            BrandsAppleDataModel.fromMap(result[i] as Map<String, dynamic>);
        apple.add(post);
      }
      return apple;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}

class BrandSamsungServices {
  static Future<List<BrandsSamsungDataModel>> fetchData() async {
    var client = http.Client();
    List<BrandsSamsungDataModel> samsung = [];
    try {
      var response = await client.get(Uri.parse(
          'https://asia-northeast1-wc2022-bot.cloudfunctions.net/products?brand=samsung'));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        BrandsSamsungDataModel post =
            BrandsSamsungDataModel.fromMap(result[i] as Map<String, dynamic>);
        samsung.add(post);
      }
      return samsung;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
