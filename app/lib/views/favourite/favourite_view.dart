import 'package:app/model/product_model.dart';
import 'package:app/services/favourite_services.dart';
import 'package:app/views/favourite/widgets/favourite_single_product.dart';
import 'package:flutter/material.dart';
import '../../constance/global_variebles.dart';
import '../common/custom_app_bar.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  List<ProductModel> products = [];
  FavouriteServices favouriteServices = FavouriteServices();

  void getProducts(BuildContext context) async {
    products = await favouriteServices.featchFavProducts(context: context);
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          if (products.isNotEmpty) showProducts(itemWidth, itemHeight),
          if (products.isEmpty) showDummy(itemWidth, itemHeight),
        ],
      ),
    );
  }

  Widget showProducts(itemWidth, itemHeight) => Expanded(
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (itemWidth / itemHeight),
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: ((context, index) {
            return FavouriteProduct(
              product: products[index],
              callback: () {
                products.removeAt(index);
                setState(() {});
              },
            );
          }),
        ),
      );

  Widget showDummy(itemWidth, itemHeight) => Expanded(
        child: Container(
          color: GlobalVariebles().bagroundWhite,
          child: GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: ((context, index) {
              return Container(
                color: Colors.black12,
              );
            }),
          ),
        ),
      );
}
