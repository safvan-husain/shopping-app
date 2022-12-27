// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/model/product_model.dart';
import 'package:app/provider/user_provider.dart';
import 'package:app/route/router.gr.dart';
import 'package:app/services/product_services.dart';

class CartProduct extends StatefulWidget {
  final ProductModel product;
  final VoidCallback callback;
  const CartProduct({
    Key? key,
    required this.product,
    required this.callback,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  ProductServices productServices = ProductServices();
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2;
    var cartitems = context.read<UserProvider>().user.cart;

    //finding quantity of product'
    for (int i = 0; i < cartitems.length; i++) {
      if (cartitems[i].product.id == widget.product.id) {
        quantity = cartitems[i].quantity;
      }
    }
    return InkWell(
      onTap: () {
        context.router.push(
          CartProductRoute(product: widget.product),
        );
      },
      child: builtProductTile(width),
    );
  }

  Widget builtProductTile(width) => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Hero(
                    tag: widget.product.name,
                    child: Image.network(widget.product.images[0])),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.product.name,
                      style: TextStyle(
                        fontSize: width * 0.10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '₹${widget.product.price.toInt()}',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: width * 0.09,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      productServices.addTocart(
                        context,
                        widget.product.id,
                        1,
                        () {
                          widget.callback();
                        },
                      );
                    },
                    icon: const Icon(
                      size: 20,
                      Icons.add_circle_rounded,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(quantity.toString()),
                )),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      productServices.removeItemFromCart(
                        context,
                        widget.product.id,
                        () {
                          widget.callback();
                        },
                      );
                    },
                    icon: const Icon(
                      size: 20,
                      Icons.remove_circle_rounded,
                      color: Colors.black38,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            )
          ],
        ),
      );
}
