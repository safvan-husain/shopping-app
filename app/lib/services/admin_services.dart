import 'dart:convert';
import 'dart:developer';

import 'package:app/constance/http_error_handler.dart';
import 'package:app/model/product_model.dart';
import 'package:app/provider/user_provider.dart';
import 'package:app/utils/shared_preference.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/constance/global_variebles.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

enum Category { men, women, kids }

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String category,
    required int price,
    required List<dynamic> images,
  }) async {
    ProductModel product = ProductModel(
      id: '',
      name: name,
      price: price.toDouble(),
      images: images,
      category: category,
    );
    var token = await ManageToken.getAuthToken();
    http.Response res = await http.post(
      Uri.parse('$uri/add-product'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': token!,
      },
      body: product.toJson(),
    );
    httpErrorHandler(
      res: res,
      context: context,
      onSuccess: () {
        product = ProductModel.fromJson(res.body);
        context.router.pop();
      },
    );
  }

  Future<List<ProductModel>> getProducts(BuildContext context) async {
    List<ProductModel> products = [];
    var token = await ManageToken.getAuthToken();
    http.Response res = await http.get(
      Uri.parse('$uri/get-all-product'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': token!,
      },
    );
    httpErrorHandler(
      res: res,
      context: context,
      onSuccess: () {
        List array = jsonDecode(res.body);
        for (int i = 0; i < array.length; i++) {
          products.add(ProductModel.fromMap(array[i]));
        }
      },
    );
    return products;
  }

  Future<List<ProductModel>> deleteProduct({
    required BuildContext context,
    required String id,
  }) async {
    List<ProductModel> products = [];
    var token = await ManageToken.getAuthToken();
    http.Response res = await http.delete(
      Uri.parse('$uri/delete-product/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': token!,
      },
    );
    httpErrorHandler(
      res: res,
      context: context,
      onSuccess: () {
        // print(res.body);
      },
    );
    return products;
  }
}
