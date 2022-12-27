import 'dart:convert';
import 'package:app/model/cartItem.dart';
import 'package:app/model/product_model.dart';
import 'package:app/provider/user_provider.dart';
import 'package:app/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constance/global_variebles.dart';
import '../constance/http_error_handler.dart';

class ProductServices {
  Future<List<ProductModel>> getOrderdProducts(BuildContext context) async {
    var token = await ManageToken.getAuthToken();
    List<ProductModel> products = [];
    http.Response res = await http.get(
      Uri.parse('$uri/get-ordered-products'),
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

  Future<List<CartItem>> getCart(BuildContext context) async {
    var token = await ManageToken.getAuthToken();
    List<CartItem> cartItems = [];
    http.Response res = await http.get(
      Uri.parse('$uri/get-cart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': token!,
      },
    );
    httpErrorHandler(
      res: res,
      context: context,
      onSuccess: () {
        var array = jsonDecode(res.body);
        for (int i = 0; i < array.length; i++) {
          cartItems.add(CartItem.fromMap(array[i]));
        }
      },
    );
    return cartItems;
  }

  void addTocart(
    BuildContext context,
    String id,
    int quantity,
    VoidCallback? callback,
  ) async {
    var user = context.read<UserProvider>().user;
    var token = await ManageToken.getAuthToken();
    http.Response res = await http.post(
      Uri.parse('$uri/add-to-cart/$id?quantity=$quantity'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': token!,
      },
    );
    httpErrorHandler(
      res: res,
      context: context,
      onSuccess: () {
        var newUser = user.copyWith(
          cart: List<CartItem>.from(
            jsonDecode(res.body)['cart'].map(
              (x) => CartItem.fromMap(x),
            ),
          ),
        );
        Provider.of<UserProvider>(context, listen: false)
            .setUserFromModel(newUser);
        if (callback != null) {
          callback();
        }
      },
    );
  }

  void removeItemFromCart(
    BuildContext context,
    String id,
    VoidCallback? callback,
  ) async {
    var user = context.read<UserProvider>().user;
    var token = await ManageToken.getAuthToken();
    http.Response res = await http.get(
      Uri.parse('$uri/remove-item-cart/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': token!,
      },
    );
    httpErrorHandler(
      res: res,
      context: context,
      onSuccess: () {
        var newUser = user.copyWith(
          cart: List<CartItem>.from(
            jsonDecode(res.body)['cart'].map(
              (x) => CartItem.fromMap(x),
            ),
          ),
        );
        Provider.of<UserProvider>(context, listen: false)
            .setUserFromModel(newUser);
        if (callback != null) {
          callback();
        }
      },
    );
  }

  void clearAllCartItems(
    BuildContext context,
    VoidCallback? callback,
  ) async {
    var user = context.read<UserProvider>().user;
    var token = await ManageToken.getAuthToken();
    http.Response res = await http.delete(
      Uri.parse('$uri/delete-cart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': token!,
      },
    );
    httpErrorHandler(
      res: res,
      context: context,
      onSuccess: () {
        var newUser = user.copyWith(cart: []);
        Provider.of<UserProvider>(context, listen: false)
            .setUserFromModel(newUser);
        if (callback != null) {
          callback();
        }
      },
    );
  }
}
