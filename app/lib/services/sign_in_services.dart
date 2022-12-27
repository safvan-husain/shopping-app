import 'dart:convert';
import 'dart:developer';
import 'package:app/constance/global_variebles.dart';
import 'package:app/constance/http_error_handler.dart';
import 'package:app/provider/user_provider.dart';
import 'package:app/route/router.gr.dart';
import 'package:app/utils/shared_preference.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SignInServices {
  void login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    log(email);
    http.Response response = await http.post(
      Uri.parse('$uri/auth/sign-in'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode({
        "email": email,
        'password': password,
      }),
    );

    httpErrorHandler(
      res: response,
      context: context,
      onSuccess: () {
        Provider.of<UserProvider>(context, listen: false).setUser(
          jsonEncode(jsonDecode(response.body)['user']),
        );
        String token = jsonDecode(response.body)['token'];
        ManageToken.setAuthToken(token);
        String accountType = context.read<UserProvider>().user.type;
        if (accountType == 'user') {
          context.router.pushAndPopUntil(
            BottomNavRoute(),
            predicate: (route) => false,
          );
        } else {
          context.router.pushAndPopUntil(
            AdminRoute(),
            predicate: (route) => false,
          );
        }
      },
    );
  }

  void googleSignIn({
    required BuildContext context,
    required String email,
  }) async {
    http.Response response = await http.post(
      Uri.parse('$uri/auth/google-sign-in'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode({"email": email}),
    );

    httpErrorHandler(
      res: response,
      context: context,
      onSuccess: () {
        Provider.of<UserProvider>(context, listen: false).setUser(
          jsonEncode(jsonDecode(response.body)['user']),
        );
        String token = jsonDecode(response.body)['token'];
        ManageToken.setAuthToken(token);
        String accountType = context.read<UserProvider>().user.type;
        if (accountType == 'user') {
          context.router.pushAndPopUntil(
            BottomNavRoute(),
            predicate: (route) => false,
          );
        } else {
          context.router.pushAndPopUntil(
            const AdminRoute(),
            predicate: (route) => false,
          );
        }
      },
    );
  }
}
