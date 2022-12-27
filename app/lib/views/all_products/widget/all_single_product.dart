// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app/model/user_model.dart';
import 'package:app/provider/user_provider.dart';
import 'package:app/route/router.gr.dart';
import 'package:app/services/home_services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:app/model/product_model.dart';
import 'package:provider/provider.dart';

class SingleProduct extends StatefulWidget {
  final ProductModel product;
  const SingleProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  late UserModel user;
  @override
  void initState() {
    super.initState();
    // onFavChange(context);
  }

  IconData icon = Icons.favorite_outline;

  void favouriteIcon(BuildContext context) {
    user = context.read<UserProvider>().user;
    for (int i = 0; i < user.favourites.length; i++) {
      if (user.favourites[i].id == widget.product.id) {
        icon = Icons.favorite;
        break;
      } else {
        icon = Icons.favorite_outline;
      }
    }
    // if (!mounted) return;
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    favouriteIcon(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
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
                            callback: () {
                              // if (icon == Icons.favorite) {
                              //   icon = Icons.favorite_outline;
                              // } else {
                              //   icon = Icons.favorite;
                              // }
                              // onFavChange(context);
                              setState(() {});
                            },
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
