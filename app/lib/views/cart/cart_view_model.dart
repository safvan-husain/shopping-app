import 'package:app/services/product_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends BaseViewModel {
  ProductServices productServices = ProductServices();
  void clearCart(BuildContext context) {
    productServices.clearAllCartItems(context, () {});
  }
}
