// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/constance/global_variebles.dart';
import 'package:flutter/material.dart';

import 'package:app/model/product_model.dart';

class CartProductView extends StatelessWidget {
  final ProductModel product;
  const CartProductView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: GlobalVariebles().bagroundWhite,
        child: Column(
          children: [
            SizedBox(
              child: Image.network(
                product.images[0],
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 28,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,),
                      const Icon(
                        Icons.star_rate,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has beLorem Ipsum."),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
