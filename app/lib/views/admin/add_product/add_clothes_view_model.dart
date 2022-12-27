import 'dart:developer';

import 'package:app/route/router.gr.dart';
import 'package:app/services/admin_services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class AddClothesModelView extends BaseViewModel {
  FilePickerResult? _result;
  FilePickerResult? get result => _result;

  AdminServices adminServices = AdminServices();
  final cloudinary = CloudinaryPublic('djrmgocda', 'ktwsuong');

  List<dynamic> images = [];

  String _category = 'men';
  String get categori => _category;

  void setCategory(String cat) {
    log(cat.toString());
    _category = cat;
    notifyListeners();
  }

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get priceController => _priceController;

  void pickImage() async {
    _result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (_result != null) log(_result!.paths.toString());
    notifyListeners();
  }

  Future<List<dynamic>> uploadImages() async {
    if (_result != null) {
      for (int i = 0; i < _result!.count; i++) {
        CloudinaryResponse res =
            await cloudinary.uploadFile(CloudinaryFile.fromFile(
          _result!.paths[i] as String,
          folder: _nameController.text,
        ));
        log(res.secureUrl);
        images.add(res.secureUrl);
      }
    }
    return images;
  }

  void submit(BuildContext context) async {
    if (_result != null) {
      images = await uploadImages();
      adminServices.sellProduct(
        context: context,
        name: _nameController.text,
        price: int.parse(_priceController.text),
        images: images,
        category: _category.toString(),
      );
      context.router.pushAndPopUntil(
        const AdminRoute(),
        predicate: (Route<dynamic> route) => false,
      );
    }
  }
}
