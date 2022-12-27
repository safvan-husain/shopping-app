import 'package:app/route/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class InitialViewModel extends BaseViewModel {
  void navigateTOSignIn(BuildContext context) {
    context.router.push(const SignInRoute());
  }

  void navigateToSignUp(BuildContext context) {
    context.router.push(const SignUpRoute());
  }
}
