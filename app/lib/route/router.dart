import 'package:app/views/BottomNav/bottom_nav_view.dart';
import 'package:app/views/admin/add_product/add_clothes_view.dart';
import 'package:app/views/admin/admin_view.dart';
import 'package:app/views/all_products/all_product_view.dart';
import 'package:app/views/cart/cart_view.dart';
import 'package:app/views/cart/widgets/prodoct_view_cart.dart';
import 'package:app/views/initialScreen/initial_view.dart';
import 'package:app/views/product/product_view.dart';
import 'package:app/views/profile/pages/edit_profile.dart';
import 'package:app/views/profile/pages/order_location.dart';
import 'package:app/views/profile/profile_view.dart';
import 'package:app/views/sign_in/sign_in_view.dart';
import 'package:app/views/signup/sign_up_view.dart';
import 'package:auto_route/auto_route.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: InitialView, initial: true),
    AutoRoute(page: SignInView),
    AutoRoute(page: SignUpView),
    AutoRoute(page: BottomNavView),
    AutoRoute(page: AdminView),
    AutoRoute(page: AddClothesView),
    AutoRoute(page: ProductView),
    AutoRoute(page: CartView),
    AutoRoute(page: CartProductView),
    AutoRoute(page: ProfileView),
    AutoRoute(page: AllProductView),
    AutoRoute(page: EditProfileView),
    AutoRoute(page: OrderLocationView),
  ],
)
class $AppRouter {}
