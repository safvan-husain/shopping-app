import 'package:app/model/user_model.dart';
import 'package:app/provider/user_provider.dart';
import 'package:app/route/router.gr.dart';
import 'package:app/services/profile_services.dart';
import 'package:app/utils/shared_preference.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final TextEditingController nameController = TextEditingController();
  ProfileServices profileServices = ProfileServices();
  FilePickerResult? result;
  final cloudinary = CloudinaryPublic('djrmgocda', 'ktwsuong');
  Future<void> editName(BuildContext context, VoidCallback callback) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Name'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.length > 4) {
                  profileServices.editUserName(
                    context: context,
                    name: nameController.text,
                    callback: () {
                      Navigator.of(context).pop();
                      nameController.text = '';
                      callback();
                    },
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void pickImage() async {
    result = await FilePicker.platform.pickFiles(type: FileType.image);
  }

  Future<String> uploadImage() async {
    CloudinaryResponse response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(
        result!.paths[0]!,
        resourceType: CloudinaryResourceType.Image,
      ),
    );
    return response.secureUrl;
  }

  void updateAvatar({
    required BuildContext context,
    required VoidCallback callback,
  }) async {
    pickImage();
    if (result != null) {
      var avatarUrl = await uploadImage();
      profileServices.updateUserAvatar(
        context: context,
        avatarUrl: avatarUrl,
        callback: callback,
      );
    }
  }

  void onLogOut(BuildContext context) async {
    UserModel user = UserModel(
      id: '',
      name: '',
      email: '',
      avatar: '',
      type: '',
      favourites: [],
      cart: [],
    );
    Provider.of<UserProvider>(context, listen: false).setUserFromModel(user);
    ManageToken.setAuthToken('');
    context.router.pushAndPopUntil(
      const InitialRoute(),
      predicate: (route) => false,
    );
  }

  Future<void> showLogOutDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirm LogOut'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  onLogOut(context);
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: const Text('LogOut'),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
            ],
          );
        });
  }
}
