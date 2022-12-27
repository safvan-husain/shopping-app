import 'dart:convert';

import 'package:app/model/cartItem.dart';
import 'package:app/model/product_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final String type;
  final List<ProductModel> favourites;
  final List<CartItem> cart;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.type,
    required this.favourites,
    required this.cart,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'type': type,
      'favourites': favourites,
      'cart': cart
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      avatar: map['avatar'] as String,
      type: map['type'] as String,
      favourites: List<ProductModel>.from(map['favourites'] != []
          ? map['favourites'].map(
              (x) => ProductModel.fromMap(x),
            )
          : []),
      cart: List<CartItem>.from(
        map['cart'].map(
          (x) => CartItem.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    String? type,
    List<ProductModel>? favourites,
    List<CartItem>? cart,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      type: type ?? this.type,
      favourites: favourites ?? this.favourites,
      cart: cart ?? this.cart,
    );
  }
}
