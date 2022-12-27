import 'package:app/route/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

import '../../constance/global_variebles.dart';
import '../../provider/user_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().user;
    return AppBar(
      leadingWidth: 50,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          onTap: () {
            context.router.push(const ProfileRoute());
          },
          child: SizedBox(
            child: Hero(
              tag: context.read<UserProvider>().user.id,
              child: CircleAvatar(
                radius: 5,
                backgroundImage: NetworkImage(context
                        .read<UserProvider>()
                        .user
                        .avatar
                        .isNotEmpty
                    ? context.read<UserProvider>().user.avatar
                    : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
              ),
            ),
          ),
        ),
      ),
      elevation: 0,
      backgroundColor: GlobalVariebles().bagroundWhite,
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              context.router.push(const CartRoute());
            },
            child: Badge(
              badgeContent: Text(user.cart.length.toString()),
              showBadge: user.cart.isNotEmpty ? true : false,
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
