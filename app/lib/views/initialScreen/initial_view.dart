import 'package:app/model/user_model.dart';
import 'package:app/provider/user_provider.dart';
import 'package:app/views/admin/admin_view.dart';
import 'package:app/views/common/custom_button.dart';
import 'package:app/views/BottomNav/bottom_nav_view.dart';
import 'package:app/views/initialScreen/initial_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class InitialView extends StatelessWidget {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = context.watch<UserProvider>().user;
    return ViewModelBuilder<InitialViewModel>.nonReactive(
      builder: ((context, model, child) {
        return user.name.isNotEmpty
            ? user.type == 'user'
                ? const BottomNavView()
                : const AdminView()
            : Scaffold(
                body: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: const FittedBox(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'WELCOME',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        builtButtons(
                          context,
                          model,
                          () => model.navigateTOSignIn(context),
                        )
                      ],
                    ),
                  ),
                ),
              );
      }),
      viewModelBuilder: () => InitialViewModel(),
    );
  }

  Widget builtButtons(context, model, navigate) => Column(
        children: [
          CoustomButton(
            onTap: navigate,
            text: 'Alredy a member?',
            color: const Color.fromARGB(188, 168, 31, 45),
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () => model.navigateToSignUp(context),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: const Text(
                'Don\'t have an Account?',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      );
}
