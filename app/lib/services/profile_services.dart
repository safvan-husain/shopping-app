import 'dart:convert';
import 'dart:developer';

import 'package:app/constance/global_variebles.dart';
import 'package:app/constance/http_error_handler.dart';
import 'package:app/provider/user_provider.dart';
import 'package:app/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProfileServices {
  void editUserName({
    required BuildContext context,
    required String name,
    required VoidCallback callback,
  }) async {
    var token = await ManageToken.getAuthToken();
    http.Response res = await http.post(
      Uri.parse(
        '$uri/edit-name',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': token!,
      },
      body: jsonEncode({'name': name}),
    );
    httpErrorHandler(
      res: res,
      context: context,
      onSuccess: () {
        var user = context.watch<UserProvider>().user;
        var newUser = user.copyWith(name: name);
        Provider.of<UserProvider>(context, listen: false)
            .setUserFromModel(newUser);
        callback();
      },
    );
  }

  void updateUserAvatar({
    required BuildContext context,
    required String avatarUrl,
    required VoidCallback callback,
  }) async {
    log('called');
    var token = await ManageToken.getAuthToken();
    http.Response res = await http.post(
      Uri.parse(
        '$uri/update-avatar',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': token!,
      },
      body: jsonEncode({'avatar': avatarUrl}),
    );
    httpErrorHandler(
      res: res,
      context: context,
      onSuccess: () {
        var user = context.watch<UserProvider>().user;
        var newUser = user.copyWith(avatar: avatarUrl);
        Provider.of<UserProvider>(context, listen: false)
            .setUserFromModel(newUser);
        callback();
      },
    );
  }
}
