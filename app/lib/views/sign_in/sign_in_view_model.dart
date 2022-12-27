import 'dart:developer';

import 'package:app/constance/api_google_signin.dart';
import 'package:app/route/router.gr.dart';
import 'package:app/services/sign_in_services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';

class SignInViewModel extends BaseViewModel {
  final String _name = 'sign in';
  String get name => _name;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formkey => _formKey;

  final SignInServices services = SignInServices();
  GoogleSignInApi _googleSignInApi = GoogleSignInApi();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GoogleSignInAccount? account;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  void navigate(BuildContext context) {
    context.router.push(const SignUpRoute());
  }

  void googleSignIn(BuildContext context) async {
    await GoogleSignInApi.logout();
    account = await GoogleSignInApi.login();
    if (account?.email != null) {
      services.googleSignIn(
        context: context,
        email: account!.email,
      );
    }
  }

  void signIn({
    required BuildContext context,
  }) {
    services.login(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }
}
