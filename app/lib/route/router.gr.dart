// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/model/product_model.dart' as _i16;
import 'package:app/model/user_model.dart' as _i17;
import 'package:app/views/admin/add_product/add_clothes_view.dart' as _i6;
import 'package:app/views/admin/admin_view.dart' as _i5;
import 'package:app/views/all_products/all_product_view.dart' as _i11;
import 'package:app/views/BottomNav/bottom_nav_view.dart' as _i4;
import 'package:app/views/cart/cart_view.dart' as _i8;
import 'package:app/views/cart/widgets/prodoct_view_cart.dart' as _i9;
import 'package:app/views/initialScreen/initial_view.dart' as _i1;
import 'package:app/views/product/product_view.dart' as _i7;
import 'package:app/views/profile/pages/edit_profile.dart' as _i12;
import 'package:app/views/profile/pages/order_location.dart' as _i13;
import 'package:app/views/profile/profile_view.dart' as _i10;
import 'package:app/views/sign_in/sign_in_view.dart' as _i2;
import 'package:app/views/signup/sign_up_view.dart' as _i3;
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;

class AppRouter extends _i14.RootStackRouter {
  AppRouter([_i15.GlobalKey<_i15.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    InitialRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.InitialView(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.SignInView(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.SignUpView(),
      );
    },
    BottomNavRoute.name: (routeData) {
      final args = routeData.argsAs<BottomNavRouteArgs>(
          orElse: () => const BottomNavRouteArgs());
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i4.BottomNavView(key: args.key),
      );
    },
    AdminRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.AdminView(),
      );
    },
    AddClothesRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i6.AddClothesView(),
      );
    },
    ProductRoute.name: (routeData) {
      final args = routeData.argsAs<ProductRouteArgs>();
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i7.ProductView(
          key: args.key,
          product: args.product,
        ),
      );
    },
    CartRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i8.CartView(),
      );
    },
    CartProductRoute.name: (routeData) {
      final args = routeData.argsAs<CartProductRouteArgs>();
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i9.CartProductView(
          key: args.key,
          product: args.product,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i10.ProfileView(),
      );
    },
    AllProductRoute.name: (routeData) {
      final args = routeData.argsAs<AllProductRouteArgs>();
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i11.AllProductView(
          key: args.key,
          products: args.products,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i12.EditProfileView(
          key: args.key,
          user: args.user,
        ),
      );
    },
    OrderLocationRoute.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i13.OrderLocationView(),
      );
    },
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(
          InitialRoute.name,
          path: '/',
        ),
        _i14.RouteConfig(
          SignInRoute.name,
          path: '/sign-in-view',
        ),
        _i14.RouteConfig(
          SignUpRoute.name,
          path: '/sign-up-view',
        ),
        _i14.RouteConfig(
          BottomNavRoute.name,
          path: '/bottom-nav-view',
        ),
        _i14.RouteConfig(
          AdminRoute.name,
          path: '/admin-view',
        ),
        _i14.RouteConfig(
          AddClothesRoute.name,
          path: '/add-clothes-view',
        ),
        _i14.RouteConfig(
          ProductRoute.name,
          path: '/product-view',
        ),
        _i14.RouteConfig(
          CartRoute.name,
          path: '/cart-view',
        ),
        _i14.RouteConfig(
          CartProductRoute.name,
          path: '/cart-product-view',
        ),
        _i14.RouteConfig(
          ProfileRoute.name,
          path: '/profile-view',
        ),
        _i14.RouteConfig(
          AllProductRoute.name,
          path: '/all-product-view',
        ),
        _i14.RouteConfig(
          EditProfileRoute.name,
          path: '/edit-profile-view',
        ),
        _i14.RouteConfig(
          OrderLocationRoute.name,
          path: '/order-location-view',
        ),
      ];
}

/// generated route for
/// [_i1.InitialView]
class InitialRoute extends _i14.PageRouteInfo<void> {
  const InitialRoute()
      : super(
          InitialRoute.name,
          path: '/',
        );

  static const String name = 'InitialRoute';
}

/// generated route for
/// [_i2.SignInView]
class SignInRoute extends _i14.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/sign-in-view',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.SignUpView]
class SignUpRoute extends _i14.PageRouteInfo<void> {
  const SignUpRoute()
      : super(
          SignUpRoute.name,
          path: '/sign-up-view',
        );

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i4.BottomNavView]
class BottomNavRoute extends _i14.PageRouteInfo<BottomNavRouteArgs> {
  BottomNavRoute({_i15.Key? key})
      : super(
          BottomNavRoute.name,
          path: '/bottom-nav-view',
          args: BottomNavRouteArgs(key: key),
        );

  static const String name = 'BottomNavRoute';
}

class BottomNavRouteArgs {
  const BottomNavRouteArgs({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return 'BottomNavRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.AdminView]
class AdminRoute extends _i14.PageRouteInfo<void> {
  const AdminRoute()
      : super(
          AdminRoute.name,
          path: '/admin-view',
        );

  static const String name = 'AdminRoute';
}

/// generated route for
/// [_i6.AddClothesView]
class AddClothesRoute extends _i14.PageRouteInfo<void> {
  const AddClothesRoute()
      : super(
          AddClothesRoute.name,
          path: '/add-clothes-view',
        );

  static const String name = 'AddClothesRoute';
}

/// generated route for
/// [_i7.ProductView]
class ProductRoute extends _i14.PageRouteInfo<ProductRouteArgs> {
  ProductRoute({
    _i15.Key? key,
    required _i16.ProductModel product,
  }) : super(
          ProductRoute.name,
          path: '/product-view',
          args: ProductRouteArgs(
            key: key,
            product: product,
          ),
        );

  static const String name = 'ProductRoute';
}

class ProductRouteArgs {
  const ProductRouteArgs({
    this.key,
    required this.product,
  });

  final _i15.Key? key;

  final _i16.ProductModel product;

  @override
  String toString() {
    return 'ProductRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i8.CartView]
class CartRoute extends _i14.PageRouteInfo<void> {
  const CartRoute()
      : super(
          CartRoute.name,
          path: '/cart-view',
        );

  static const String name = 'CartRoute';
}

/// generated route for
/// [_i9.CartProductView]
class CartProductRoute extends _i14.PageRouteInfo<CartProductRouteArgs> {
  CartProductRoute({
    _i15.Key? key,
    required _i16.ProductModel product,
  }) : super(
          CartProductRoute.name,
          path: '/cart-product-view',
          args: CartProductRouteArgs(
            key: key,
            product: product,
          ),
        );

  static const String name = 'CartProductRoute';
}

class CartProductRouteArgs {
  const CartProductRouteArgs({
    this.key,
    required this.product,
  });

  final _i15.Key? key;

  final _i16.ProductModel product;

  @override
  String toString() {
    return 'CartProductRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i10.ProfileView]
class ProfileRoute extends _i14.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: '/profile-view',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i11.AllProductView]
class AllProductRoute extends _i14.PageRouteInfo<AllProductRouteArgs> {
  AllProductRoute({
    _i15.Key? key,
    required List<_i16.ProductModel> products,
  }) : super(
          AllProductRoute.name,
          path: '/all-product-view',
          args: AllProductRouteArgs(
            key: key,
            products: products,
          ),
        );

  static const String name = 'AllProductRoute';
}

class AllProductRouteArgs {
  const AllProductRouteArgs({
    this.key,
    required this.products,
  });

  final _i15.Key? key;

  final List<_i16.ProductModel> products;

  @override
  String toString() {
    return 'AllProductRouteArgs{key: $key, products: $products}';
  }
}

/// generated route for
/// [_i12.EditProfileView]
class EditProfileRoute extends _i14.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i15.Key? key,
    required _i17.UserModel user,
  }) : super(
          EditProfileRoute.name,
          path: '/edit-profile-view',
          args: EditProfileRouteArgs(
            key: key,
            user: user,
          ),
        );

  static const String name = 'EditProfileRoute';
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.user,
  });

  final _i15.Key? key;

  final _i17.UserModel user;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i13.OrderLocationView]
class OrderLocationRoute extends _i14.PageRouteInfo<void> {
  const OrderLocationRoute()
      : super(
          OrderLocationRoute.name,
          path: '/order-location-view',
        );

  static const String name = 'OrderLocationRoute';
}
