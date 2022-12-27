import 'dart:developer';

import 'package:app/model/product_model.dart';
import 'package:app/route/router.gr.dart';
import 'package:app/services/admin_services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class AdminViewModel extends BaseViewModel {
  AdminServices adminServices = AdminServices();

  void navigateToAdd(BuildContext context) {
    context.router.push(const AddClothesRoute());
  }

  List<ProductModel>? _products = [];
  List<ProductModel>? get products => _products;

  void fetchProducts(BuildContext context) async {
    _products = await adminServices.getProducts(context);
  }

  void deleteproduct(BuildContext context, String id) {
    adminServices.deleteProduct(
      context: context,
      id: id,
    );
  }
}
