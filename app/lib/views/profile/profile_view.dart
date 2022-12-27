import 'package:app/constance/global_variebles.dart';
import 'package:app/provider/user_provider.dart';
import 'package:app/route/router.gr.dart';
import 'package:app/views/profile/profile_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = context.watch<UserProvider>().user;
    return ViewModelBuilder.nonReactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: GlobalVariebles().bagroundWhite,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size(80, 80),
            child: AppBar(
              elevation: 0,
              backgroundColor: GlobalVariebles().bagroundWhite,
              centerTitle: true,
              title: const Text(
                'Profile',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.router.push(EditProfileRoute(user: user));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height / 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Hero(
                              tag: user.id,
                              child: CircleAvatar(
                                maxRadius: size.height / 12,
                                backgroundImage: NetworkImage(user
                                        .avatar.isNotEmpty
                                    ? user.avatar
                                    : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        onTap: () {
                          context.router.push(EditProfileRoute(user: user));
                        },
                        leading: const Icon(
                          Icons.cabin,
                        ),
                        title: const Text('Edit Profile'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {
                          context.router.push(const OrderLocationRoute());
                        },
                        leading: const Icon(
                          Icons.location_pin,
                        ),
                        title: const Text('Order location'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      const ListTile(
                        leading: Icon(
                          Icons.history,
                        ),
                        title: Text('Order history'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      const ListTile(
                        leading: Icon(
                          Icons.notifications,
                        ),
                        title: Text('Notifications'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      const ListTile(
                        leading: Icon(
                          Icons.payment,
                        ),
                        title: Text('Cards'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {
                          model.showLogOutDialog(context);
                        },
                        leading: const Icon(
                          Icons.logout,
                        ),
                        title: const Text('Log Out'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
