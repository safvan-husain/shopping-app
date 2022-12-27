// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:stacked/stacked.dart';

import '../../model/product_model.dart';

class AllProductViewModel extends BaseViewModel {
  final List<ProductModel> products;

  AllProductViewModel({
    required this.products,
  });

  String _minValue = '0';
  final List<String> _min = [
    '0',
    '200',
    '400',
    '800',
  ];
  String _maxValue = '1000+';
  String _maxValueFilter = '1000+';
  final List<String> _max = [
    '200',
    '400',
    '800',
    '1000',
    '1000+',
  ];
  List<String> get min => _min;
  List<String> get max => _max;

  String get minValue => _minValue;
  String get maxValue => _maxValue;

  void setMinValue(String value) {
    _minValue = value;
    // notifyListeners();
  }

  void setMaxValue(String value) {
    _maxValue = value;
    _maxValueFilter = value;
    // notifyListeners();
  }

  List<String> _filterCategories = [];

  List<String> get filterCategories => _filterCategories;
  void setCategories(List<String> categroies) {
    _filterCategories = [];
    for (var e in categroies) {
      _filterCategories.add(e);
    }

    notifyListeners();
  }

  List<ProductModel> resetFilter() {
    return products;
  }

  List<ProductModel> filter() {
    if (_filterCategories.isEmpty) {
      _filterCategories = ['men', 'women', 'kids'];
    }
    List<ProductModel> pro = [];
    List<ProductModel> specificProducts = [];

    for (int i = 0; i < _filterCategories.length; i++) {
      for (var product in products) {
        if (product.category == _filterCategories[i]) {
          pro.add(product);
        }
      }
    }
    _filterCategories = [];

    if (_maxValueFilter == '1000+') {
      _maxValueFilter = '10000';
    }
    for (var product in pro) {
      if (product.price > double.parse(_minValue) &&
          product.price < double.parse(_maxValueFilter)) {
        specificProducts.add(product);
      }
    }
    return specificProducts;
  }
}
