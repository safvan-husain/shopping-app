// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:app/model/product_model.dart';
import 'package:app/views/product/product_view_model.dart';

class ProductView extends StatefulWidget {
  final ProductModel product;
  const ProductView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: ((context, model, child) {
        model.initialState(context);
        return Scaffold(
          body: SafeArea(
            child: Stack(children: [
              Align(
                alignment: Alignment.topLeft,
                child: Hero(
                  tag: widget.product.id,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      image: DecorationImage(
                        alignment: Alignment.topLeft,
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          widget.product.images[0],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 28,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
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
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Qty :',
                                  style: TextStyle(
                                    color: Colors.black38,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    model.onQuantityDecrement();
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle_rounded,
                                    color: Colors.black38,
                                  ),
                                ),
                                Text('${model.quantity}'),
                                IconButton(
                                    onPressed: () {
                                      model.onQuantityIncrement();
                                    },
                                    icon: const Icon(
                                      Icons.add_circle_rounded,
                                      color: Colors.black38,
                                    ))
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Total: ',
                                style: const TextStyle(color: Colors.black26),
                                children: [
                                  TextSpan(
                                      text: model.totalPrice.toInt().toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton.icon(
                          onPressed: () {
                            model.addToCart(context);
                          },
                          icon: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      model.onFavChange(context);
                    },
                    child: Icon(
                      model.icon,
                      size: 40,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
              )
            ]),
          ),
        );
      }),
      viewModelBuilder: () => ProductViewModel(
        product: widget.product,
        setState: () {
          setState(() {});
        },
      ),
    );
  }
}
