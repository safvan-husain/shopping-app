import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response res,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  log(res.statusCode.toString());
  switch (res.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      log((res.body));
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(
      //       jsonDecode(res.body)['msg'],
      //     ),
      //   ),
      // );
      break;
    case 500:
      log(jsonDecode(res.body)['error']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            jsonDecode(res.body)['error'],
          ),
        ),
      );
      break;
    default:
  }
}
