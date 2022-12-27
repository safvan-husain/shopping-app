import 'package:app/views/favourite/favourite_view.dart';
import 'package:app/views/home/home_view.dart';
import 'package:app/views/orders/orders_view.dart';
import 'package:app/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BottomNavViewModel extends BaseViewModel {
  final List<Widget> _pages = const [
    HomeView(),
    FavouriteView(),
    OrdersView(),
    ProfileView(),
  ];

  List<Widget> get pages => _pages;
}
