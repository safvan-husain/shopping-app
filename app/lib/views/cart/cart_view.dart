import 'dart:developer';

import 'package:app/model/cartItem.dart';
import 'package:app/services/product_services.dart';
import 'package:app/views/cart/cart_view_model.dart';
import 'package:app/views/cart/widgets/cart_view_product.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../constance/global_variebles.dart';
import '../../provider/user_provider.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  ProductServices productServices = ProductServices();
  List<CartItem> cartItems = [];
  final List<PaymentItem> _paymentItems = [];
  double total = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    cartItems = context.watch<UserProvider>().user.cart;
    total = 0;
    //finding total amount of all the cart items'
    for (int i = 0; i < cartItems.length; i++) {
      total += (cartItems[i].product.price * cartItems[i].quantity);
    }
    _paymentItems.add(
      PaymentItem(
        label: "total",
        amount: total.toString(),
        status: PaymentItemStatus.final_price,
      ),
    );
    return ViewModelBuilder.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: builtAppBar(model),
          body: Container(
              color: GlobalVariebles().bagroundWhite,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (cartItems.isNotEmpty) showCartItems(size),
                    if (cartItems.isEmpty)
                      const Center(child: Text('Cart is Empty')),
                    builtTotalPriceAndButton(model, total, size)
                  ],
                ),
              )),
        );
      },
      viewModelBuilder: () => CartViewModel(),
    );
  }

  AppBar builtAppBar(model) => AppBar(
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            child: CircleAvatar(
              radius: 5,
              backgroundImage: NetworkImage(context
                      .read<UserProvider>()
                      .user
                      .avatar
                      .isNotEmpty
                  ? context.read<UserProvider>().user.avatar
                  : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: GlobalVariebles().bagroundWhite,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                model.clearCart(context);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          ),
        ],
      );

  Widget showCartItems(size) => Expanded(
        child: GridView.builder(
          itemCount: cartItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: size.height / (size.width * 0.5),
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return CartProduct(
              product: cartItems.elementAt(index).product,
              callback: () {
                setState(() {});
              },
            );
          },
        ),
      );

  void onGooglePayResult(paymentResult) {
    log(paymentResult);
    log('yes');
  }

  Widget builtTotalPriceAndButton(model, total, size) => Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₹${total.toInt()}',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            GooglePayButton(
              paymentConfigurationAsset: 'gpay.json',
              paymentItems: _paymentItems,
              type: GooglePayButtonType.pay,
              onPaymentResult: onGooglePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      );
}
