import 'dart:convert';
import 'dart:developer';
import 'package:app/constance/global_variebles.dart';
import 'package:app/constance/http_error_handler.dart';
import 'package:app/model/product_model.dart';
import 'package:app/model/user_model.dart';
import 'package:app/provider/user_provider.dart';
import 'package:app/utils/shared_preference.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeServices {
  void addToFavourite({
    required BuildContext context,
    required String id,
    required VoidCallback callback,
  }) async {
    var user = context.read<UserProvider>().user;
    var token = await ManageToken.getAuthToken();
    http.Response res = await http.put(
      Uri.parse('$uri/add-to-favourite/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': token!,
      },
    );
    httpErrorHandler(
      res: res,
      context: context,
      onSuccess: () {
        user = user.copyWith(
          favourites: List<ProductModel>.from(
            jsonDecode(res.body)['favourites'].map(
              (x) => ProductModel.fromMap(x),
            ),
          ),
        );
        Provider.of<UserProvider>(context, listen: false)
            .setUserFromModel(user);
        callback();
      },
    );
  }
}
