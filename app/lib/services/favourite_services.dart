import 'dart:convert';

import 'package:app/constance/global_variebles.dart';
import 'package:app/constance/http_error_handler.dart';
import 'package:app/model/product_model.dart';
import 'package:app/provider/user_provider.dart';
import 'package:app/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FavouriteServices {
  Future<List<ProductModel>> featchFavProducts(
      {required BuildContext context}) async {
    List<ProductModel> products = [];
    var token = await ManageToken.getAuthToken();
    http.Response res = await http.get(
      Uri.parse('$uri/get-fav-products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': token!,
      },
    );
    httpErrorHandler(
      res: res,
      context: context,
      onSuccess: () {
        products = List<ProductModel>.from(
          jsonDecode(res.body).map(
            (x) => ProductModel.fromMap(x),
          ),
        );
      },
    );
    return products;
  }
}
