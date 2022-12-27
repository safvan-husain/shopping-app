// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:app/constance/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'package:app/model/product_model.dart';
import 'package:app/services/product_services.dart';

import '../../provider/user_provider.dart';
import '../../services/home_services.dart';

class ProductViewModel extends BaseViewModel {
  final VoidCallback setState;
  final ProductModel product;
  ProductViewModel({
    required this.setState,
    required this.product,
  });
  bool isFirstInitCalling = true;
  ProductServices productServices = ProductServices();
  IconData icon = Icons.favorite_outline;
  int quantity = 1;
  double totalPrice = 0;

  void fav(BuildContext context) {
    var user = context.read<UserProvider>().user;
    for (int i = 0; i < user.favourites.length; i++) {
      icon = Icons.favorite_outline;
      if (user.favourites[i].id == product.id) {
        icon = Icons.favorite;
        break;
      }
    }
    setState();
  }

  void initialState(BuildContext context) {
    if (isFirstInitCalling) {
      totalPrice = product.price;
      isFirstInitCalling = false;
    }

    var favourites = context.watch<UserProvider>().user.favourites;
    for (int i = 0; i < favourites.length; i++) {
      if (favourites[i].id == product.id) {
        icon = Icons.favorite;
      }
    }
  }

  void onFavChange(BuildContext context) {
    HomeServices().addToFavourite(
      context: context,
      id: product.id,
      callback: () {
        fav(context);
      },
    );
  }

  void addToCart(BuildContext context) {
    productServices.addTocart(
      context,
      product.id,
      quantity,
      () {
        showSnackBar(context, 'Added to Cart');
      },
    );
  }

  void onQuantityIncrement() {
    quantity++;
    totalPrice = quantity * product.price;
    log(totalPrice.toString());
    setState();
    // notifyListeners();
  }

  void onQuantityDecrement() {
    if (quantity > 1) {
      quantity--;
      totalPrice = quantity * product.price;
      // notifyListeners();
      setState();
    }
  }
}
