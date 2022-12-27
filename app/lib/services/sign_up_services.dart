import 'dart:convert';
import 'dart:developer';
import 'package:app/utils/shared_preference.dart';
import 'package:app/constance/global_variebles.dart';
import 'package:app/constance/http_error_handler.dart';
import 'package:app/provider/user_provider.dart';
import 'package:app/route/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SignUpServices {
  void signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    String avatar = '',
  }) async {
    http.Response response = await http.post(
        Uri.parse(
          '$uri/auth/sign-up',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "avatar": avatar
        }));

    httpErrorHandler(
      res: response,
      context: context,
      onSuccess: () {
        log(response.body);
        Provider.of<UserProvider>(context, listen: false).setUser(
          jsonEncode(jsonDecode(response.body)['user']),
        );
        var token = jsonDecode(response.body)['token'];
        ManageToken.setAuthToken(token);
        context.router.pushAndPopUntil(
          BottomNavRoute(),
          predicate: (route) => false,
        );
      },
    );
  }
}
