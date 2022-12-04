import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/constants/error_handling.dart';
import 'package:flutter_application/constants/global_variables.dart';
import 'package:flutter_application/constants/utils.dart';
import 'package:flutter_application/features/auth/screens/auth_screen.dart';
import 'package:flutter_application/features/home/screens/home_screen.dart';
import 'package:flutter_application/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // SignIn
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/auth/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            await prefs.setString(
              'x-auth-token',
              jsonDecode(res.body)['token'],
            );

            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/auth/tokenIsValid'),
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/auth/'),
          headers: <String, String>{
            'content-type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        var userProvider = Provider.of<UserProvider>(
          context,
          listen: false,
        );
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      await sharedPreferences.setString('x-auth-token', '');

      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
