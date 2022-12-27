import 'package:app/views/common/custom_text_field.dart';
import 'package:app/views/signup/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:app/views/common/custom_button.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: ((context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: Container(
            color: const Color.fromARGB(255, 222, 229, 230),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  InkWell(
                    onTap: () => model.googleSignUp(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: double.infinity,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.network(
                              'http://pngimg.com/uploads/google/google_PNG19635.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          const Text(
                            'Google',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'OR',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                      key: model.formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: model.nameController,
                              text: 'Name',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              controller: model.emailController,
                              text: 'Email',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              controller: model.passwordController,
                              text: 'Password',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              controller: model.rePasswordController,
                              text: 're-Password',
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            CoustomButton(
                              onTap: () {
                                if (model.formKey.currentState!.validate()) {
                                  model.signUp(context: context);
                                }
                              },
                              text: 'Sign Up',
                              color: const Color.fromARGB(188, 168, 31, 45),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          )),
        );
      }),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
