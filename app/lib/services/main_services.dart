import 'package:app/constance/global_variebles.dart';
import 'package:app/constance/http_error_handler.dart';
import 'package:app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MainServices {
  void getUserData(BuildContext context, String token) async {
    http.Response response = await http.get(
      Uri.parse('$uri/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': token,
      },
    );
    httpErrorHandler(
      res: response,
      context: context,
      onSuccess: () {
        Provider.of<UserProvider>(context, listen: false)
            .setUser(response.body);
      },
    );
  }
}
