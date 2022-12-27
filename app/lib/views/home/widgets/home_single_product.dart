// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/model/user_model.dart';
import 'package:app/provider/user_provider.dart';
import 'package:app/route/router.gr.dart';
import 'package:app/services/home_services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/model/product_model.dart';
import 'package:provider/provider.dart';

class HomeProduct extends StatefulWidget {
  final ProductModel product;
  const HomeProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<HomeProduct> createState() => _HomeProductState();
}

class _HomeProductState extends State<HomeProduct> {
  late UserModel user;

  IconData icon = Icons.favorite_outline;

  void favouriteIconColor(BuildContext context) {
    user = context.read<UserProvider>().user;

    for (int i = 0; i < user.favourites.length; i++) {
      icon = Icons.favorite_outline;
      if (user.favourites[i].id == widget.product.id) {
        icon = Icons.favorite;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    favouriteIconColor(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          builtImage(),
          const SizedBox(height: 2),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              builtName(),
              builtPriceAndFavIcon(),
            ],
          )
        ],
      ),
    );
  }

  Widget builtImage() => Expanded(
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
      );

  Widget builtName() => Text(
        widget.product.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );

  Widget builtPriceAndFavIcon() => Row(
        children: [
          Expanded(child: Text('₹${widget.product.price.toInt()}')),
          Expanded(
            child: IconButton(
                onPressed: () {
                  HomeServices().addToFavourite(
                    context: context,
                    id: widget.product.id,
                    callback: () {
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
      );
}
