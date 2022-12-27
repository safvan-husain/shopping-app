// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'package:app/model/user_model.dart';
import 'package:app/views/profile/profile_view_model.dart';

import '../../../constance/global_variebles.dart';
import '../../../provider/user_provider.dart';

class EditProfileView extends StatefulWidget {
  final UserModel user;
  const EditProfileView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().user;
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: ((context, model, child) {
        var size = MediaQuery.of(context).size;
        return Scaffold(
          backgroundColor: GlobalVariebles().bagroundWhite,
          appBar: PreferredSize(
            preferredSize: const Size(80, 80),
            child: AppBar(
              elevation: 0,
              backgroundColor: GlobalVariebles().bagroundWhite,
              centerTitle: true,
              title: const Text(
                'Edit Profile',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          body: SafeArea(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Hero(
                      tag: widget.user.id,
                      child: CircleAvatar(
                        maxRadius: size.height / 12,
                        backgroundImage: NetworkImage(
                          user.avatar.isNotEmpty
                              ? user.avatar
                              : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: -25,
                        child: RawMaterialButton(
                          onPressed: () {
                            model.updateAvatar(
                                context: context,
                                callback: () {
                                  setState(() {});
                                });
                          },
                          elevation: 2.0,
                          fillColor: const Color(0xFFF5F6F9),
                          padding: const EdgeInsets.all(5.0),
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.blue,
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Badge(
                    animationType: BadgeAnimationType.scale,
                    padding: const EdgeInsets.all(2),
                    badgeColor: const Color(0xFFF5F6F9),
                    badgeContent: InkWell(
                      onTap: () {
                        model.editName(context, () {
                          setState(() {});
                        });
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    stackFit: StackFit.passthrough,
                    child: Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        );
      }),
    );
  }
}
