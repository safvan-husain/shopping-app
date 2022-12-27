// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/constance/global_variebles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/model/product_model.dart';
import '../../../../route/router.gr.dart';

class SearchProduct extends StatelessWidget {
  final ProductModel product;
  const SearchProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2;
    return InkWell(
      onTap: () {
        context.router.push(
          ProductRoute(product: product),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: GlobalVariebles().bagroundWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(product.images[0]),
            ),
            const SizedBox(
              width: 4,
            ),
            builtNameAndPrice(width),
            Expanded(
              child: SizedBox(
                width: width / 6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget builtNameAndPrice(width) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              product.name,
              style: TextStyle(
                fontSize: width * 0.10,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              '₹${product.price.toInt()}',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: width * 0.09,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      );
}
