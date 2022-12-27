// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app/route/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../model/product_model.dart';
import '../../../model/user_model.dart';
import '../../../services/home_services.dart';

class FavouriteProduct extends StatefulWidget {
  final ProductModel product;
  final VoidCallback callback;
  const FavouriteProduct({
    Key? key,
    required this.product,
    required this.callback,
  }) : super(key: key);

  @override
  State<FavouriteProduct> createState() => _FavouriteProductState();
}

class _FavouriteProductState extends State<FavouriteProduct> {
  late UserModel user;

  IconData icon = Icons.favorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: widget.product.id,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    context.router.push(
                      ProductRoute(product: widget.product),
                    );
                  },
                  child: Image.network(
                    widget.product.images[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(child: Text('₹${widget.product.price.toInt()}')),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          HomeServices().addToFavourite(
                            context: context,
                            id: widget.product.id,
                            callback: widget.callback,
                          );
                        },
                        icon: Icon(
                          icon,
                          color: Colors.pink,
                        )),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
