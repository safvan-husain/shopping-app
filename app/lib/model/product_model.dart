import 'dart:convert';

import 'package:app/services/admin_services.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String id;
  final String name;
  final double price;
  final List<dynamic> images;
  final String category;
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.images,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'price': price,
      'images': images,
      'category': category,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      price: map['price'].toDouble() as double,
      images: List<String>.from(map['images'] as List<dynamic>),
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
