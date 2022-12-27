import 'package:app/model/product_model.dart';
import 'package:app/services/product_services.dart';
import 'package:app/views/orders/orders_view_model.dart';
import 'package:app/views/orders/widgets/ordered_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../constance/global_variebles.dart';
import '../../provider/user_provider.dart';
import '../common/custom_app_bar.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  List<ProductModel> products = [];
  ProductServices productServices = ProductServices();
  void getOrders(BuildContext context) async {
    products = await productServices.getOrderdProducts(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getOrders(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return ViewModelBuilder.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: CustomAppBar(),
          body: Container(
              color: GlobalVariebles().bagroundWhite,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (products.isNotEmpty)
                      Expanded(
                          child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 8,
                          crossAxisCount: 1,
                          childAspectRatio: (itemHeight) / (itemWidth / 2),
                        ),
                        itemBuilder: ((context, index) {
                          return OrderedProduct(product: products[index]);
                        }),
                        itemCount: products.length,
                      ))
                  ],
                ),
              )),
        );
      },
      viewModelBuilder: () => OrdersViewModel(),
    );
  }
}
