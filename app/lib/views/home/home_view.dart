import 'package:app/constance/global_variebles.dart';
import 'package:app/model/product_model.dart';
import 'package:app/route/router.gr.dart';
import 'package:app/services/admin_services.dart';
import 'package:app/views/common/custom_app_bar.dart';
import 'package:app/views/home/home_view_model.dart';
import 'package:app/views/home/search/coustom_search_delegate.dart';
import 'package:app/views/home/widgets/home_single_product.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AdminServices adminServices = AdminServices();
  List<ProductModel> products = [];
  void fetchProducts() async {
    products = await adminServices.getProducts(context);
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
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
          appBar: const CustomAppBar(),
          body: Container(
            color: GlobalVariebles().bagroundWhite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      builtTitleAndSearchIcon(itemWidth),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Get popular fashion from home',
                              textAlign: TextAlign.start,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.router
                                  .push(AllProductRoute(products: products));
                            },
                            child: const Text(
                              'See all',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                if (products.isEmpty) showDummy(itemWidth, itemHeight),
                if (products.isNotEmpty) showProducts(itemWidth, itemHeight),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Widget builtTitleAndSearchIcon(itemWidth) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Fashion shop',
            style:
                TextStyle(fontSize: itemWidth / 7, fontWeight: FontWeight.bold),
          ),
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(products: products),
                );
              },
              icon: const Icon(Icons.search))
        ],
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

  Widget showProducts(itemWidth, itemHeight) => Expanded(
        child: Container(
          color: GlobalVariebles().bagroundWhite,
          child: GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: ((context, index) {
              return HomeProduct(product: products[index]);
            }),
          ),
        ),
      );
}
