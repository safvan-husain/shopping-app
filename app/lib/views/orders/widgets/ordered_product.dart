// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/route/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:app/model/product_model.dart';

class OrderedProduct extends StatefulWidget {
  final ProductModel product;
  const OrderedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<OrderedProduct> createState() => _OrderedProductState();
}

class _OrderedProductState extends State<OrderedProduct> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double Height = (size.height - kToolbarHeight - 24) / 2;
    final double Width = size.width / 2;
    return InkWell(
      onTap: () {
        context.router.push(
          ProductRoute(product: widget.product),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Hero(
                  tag: widget.product.id,
                  child: Image.network(widget.product.images[0])),
              // child: NetworkImage(widget.product.images[0]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: Width * 0.1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '₹${widget.product.price.toInt()}',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: Width * 0.09,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            SizedBox(
              width: Width / 6,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      size: 20,
                      Icons.add_circle_rounded,
                      color: Colors.black38,
                    ),
                  ),
                ),
                const Text('1'),
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.remove_circle_rounded,
                      color: Colors.black38,
                      size: 20,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
