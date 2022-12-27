import 'package:app/constance/api_google_signin.dart';
import 'package:app/route/router.gr.dart';
import 'package:app/services/sign_up_services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  static String _name = 'signUp';
  String get name => _name;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  SignUpServices signUpServices = SignUpServices();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get rePasswordController => _rePasswordController;
  TextEditingController get nameController => _nameController;
  GoogleSignInAccount? account;
  void navigate(BuildContext context) {
    context.router.push(const SignInRoute());
  }

  void googleSignUp() async {
    account = await GoogleSignInApi.login();
    if (account != null) {
      _emailController.text = account!.email;
      if (account!.displayName != null) {
        _nameController.text = account!.displayName!;
      }
    }
  }

  void signUp({
    required BuildContext context,
  }) {
    if (_passwordController.text == _rePasswordController.text) {
      signUpServices.signUp(
        context: context,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        avatar: account != null ? account!.photoUrl! : '',
      );
    }
  }
}
