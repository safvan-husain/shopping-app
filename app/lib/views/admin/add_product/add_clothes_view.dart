import 'dart:developer';
import 'dart:io';

import 'package:app/services/admin_services.dart';
import 'package:app/views/admin/add_product/add_clothes_view_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddClothesView extends StatelessWidget {
  const AddClothesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: ((context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: Column(
            children: [
              const SizedBox(
                height: 50,
                width: double.infinity,
                child: Text('Add a product'),
              ),
              Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: model.pickImage,
                        child: Container(
                          height: 60,
                          color: Colors.black12,
                          child: const Center(
                            child: Text('Pick Image'),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: model.nameController,
                        decoration: const InputDecoration(hintText: 'name'),
                      ),
                      TextFormField(
                        controller: model.priceController,
                        decoration: const InputDecoration(hintText: 'price'),
                      ),
                      DropdownButton<String>(
                        value: model.categori,
                        items: Category.values.map((Category category) {
                          var categor = category
                              .toString()
                              .replaceFirst(RegExp(r'Category.'), '');
                          return DropdownMenuItem<String>(
                            value: categor,
                            child: Text(
                              category
                                  .toString()
                                  .replaceFirst(RegExp(r'Category.'), ''),
                            ),
                          );
                        }).toList(),
                        onChanged: (dynamic newValue) =>
                            model.setCategory(newValue),
                      ),
                      ElevatedButton(
                        onPressed: () => model.submit(
                          context,
                        ),
                        child: const Text('Add Product'),
                      )
                    ],
                  )),
              if (model.result != null)
                CarouselSlider.builder(
                    itemCount: model.result!.count,
                    itemBuilder: ((context, index, realIndex) {
                      return SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.file(
                            File(model.result!.paths[index] as String)),
                      );
                    }),
                    options: CarouselOptions())
            ],
          )),
        );
      }),
      viewModelBuilder: (() => AddClothesModelView()),
    );
  }
}
