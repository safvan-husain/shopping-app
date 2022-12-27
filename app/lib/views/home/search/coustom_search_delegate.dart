import 'package:app/views/home/search/widgets/search_product.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/constance/global_variebles.dart';
import 'package:app/model/product_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<ProductModel> products;
  CustomSearchDelegate({
    required this.products,
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(
      elevation: 0,
      color: GlobalVariebles().bagroundWhite,
    ));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.cancel,
          color: Colors.black12,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.router.pop();
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black12,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<ProductModel> array = [];
    for (var product in products) {
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        array.add(product);
      }
    }
    if (array.isEmpty) const Center(child: Text('No product found!'));

    return showResult(array, size);
  }

  Widget showResult(array, size) => GridView.builder(
        itemCount: array.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: size.height / (size.width * 0.5),
          mainAxisSpacing: 10,
        ),
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SearchProduct(product: array[index]),
          );
        }),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<ProductModel> array = [];

    //search logic'
    for (var product in products) {
      if (query.isEmpty) break;
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        array.add(product);
      }
    }
    if (array.isEmpty) const Center(child: Text('No product found!'));

    return showSuggestion(size, array);
  }

  Widget showSuggestion(size, array) => GridView.builder(
        itemCount: array.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: size.height / (size.width * 0.5),
          mainAxisSpacing: 10,
        ),
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SearchProduct(product: array[index]),
          );
        }),
      );
}
