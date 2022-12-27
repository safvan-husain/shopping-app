// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app/constance/global_variebles.dart';
import 'package:app/views/all_products/all_product_view_model.dart';
import 'package:app/views/all_products/widget/all_single_product.dart';
import 'package:app/views/all_products/widget/Bottom_filter_sheet.dart';
import 'package:flutter/material.dart';
import 'package:app/model/product_model.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../provider/user_provider.dart';

class AllProductView extends StatefulWidget {
  List<ProductModel> products;
  AllProductView({
    Key? key,
    required this.products,
  }) : super(key: key);
  bool isFilterPanelVisible = false;
  @override
  State<AllProductView> createState() => _AllProductViewState();
}

class _AllProductViewState extends State<AllProductView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return ViewModelBuilder.nonReactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: buildAppBar(model),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: GlobalVariebles().bagroundWhite,
              child: showAvailaleProducts(context, itemWidth, itemHeight),
            ),
          ),
          bottomSheet:
              widget.isFilterPanelVisible ? builtBottomSheet(model) : null,
        );
      },
      viewModelBuilder: () => AllProductViewModel(
        products: widget.products,
      ),
    );
  }

  AppBar buildAppBar(model) => AppBar(
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            child: CircleAvatar(
              radius: 5,
              backgroundImage: NetworkImage(context
                      .read<UserProvider>()
                      .user
                      .avatar
                      .isNotEmpty
                  ? context.read<UserProvider>().user.avatar
                  : 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.pixabay.com%2Fphoto%2F2015%2F10%2F05%2F22%2F37%2Fblank-profile-picture-973460__340.png&imgrefurl=https%3A%2F%2Fpixabay.com%2Fimages%2Fsearch%2Fuser%2F&tbnid=ksweUyHJewvXXM&vet=12ahUKEwiU7oeRsc77AhUli9gFHREdDWYQMygBegUIARDIAQ..i&docid=rmmzhVPJUKwfiM&w=340&h=340&q=demo%20avatar%20image&client=firefox-b-d&ved=2ahUKEwiU7oeRsc77AhUli9gFHREdDWYQMygBegUIARDIAQ'),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: GlobalVariebles().bagroundWhite,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                if (widget.isFilterPanelVisible) {
                  widget.isFilterPanelVisible = false;
                } else {
                  widget.isFilterPanelVisible = true;
                }

                setState(() {});
              },
              icon: const Icon(
                Icons.filter_alt,
                color: Colors.black,
              ),
            ),
          ),
        ],
      );

  Widget showAvailaleProducts(context, itemWidth, itemHeight) =>
      GridView.builder(
        itemCount: widget.products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: itemWidth / itemHeight,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: ((context, index) {
          return SingleProduct(
            product: widget.products.elementAt(index),
          );
        }),
      );

  Widget builtBottomSheet(model) => BottomSheetWidget(
        model: model,
        title: 'Filter',
        onClose: () {
          widget.isFilterPanelVisible = false;
          setState(() {});
        },
        onFilter: () {
          widget.products = model.filter();
          setState(() {});
          widget.isFilterPanelVisible = false;
        },
        onReset: () {
          widget.products = model.resetFilter();
          setState(() {});
          widget.isFilterPanelVisible = false;
        },
      );
}
