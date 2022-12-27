import 'dart:developer';

import 'package:app/model/product_model.dart';
import 'package:app/services/admin_services.dart';
import 'package:app/views/admin/admin_view_model.dart';
import 'package:app/views/admin/widgets/single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  AdminServices adminServices = AdminServices();
  List<ProductModel>? _products = [];

  void fetchProducts() async {
    _products = await adminServices.getProducts(context);
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts();
  }

  void _showDialog(int index, AdminViewModel model) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: const Text("Are you sure you want to delete?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                model.deleteproduct(context, _products![index].id);
                _products!.removeAt(index);
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return ViewModelBuilder.reactive(
      builder: ((context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: const Text('Admin')),
          body: Container(
            color: const Color.fromARGB(255, 238, 237, 237),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 20,
                  child: Text('Products  to sell'),
                ),
                if (_products!.isNotEmpty)
                  Expanded(
                    child: GridView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _products!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (itemWidth / itemHeight),
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: ((context, index) {
                        return SingleProductView(
                            onDelete: () {
                              _showDialog(index, model);
                            },
                            product: _products!.elementAt(index));
                      }),
                    ),
                  )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.navigateToAdd(context);
            },
            child: const Icon(Icons.add),
          ),
        );
      }),
      viewModelBuilder: () => AdminViewModel(),
    );
  }
}
