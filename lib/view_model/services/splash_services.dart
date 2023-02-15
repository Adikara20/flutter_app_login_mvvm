import 'package:flutter/material.dart';
import 'package:flutter_application_location/model/user_model.dart';
import 'package:flutter_application_location/utils/routes/routes_name.dart';
import 'package:flutter_application_location/view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserDate() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserDate().then((value) async {
      if (value.token == 'null' || value.token == '') {
        await Future.delayed(const Duration(seconds: 1));
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        await Future.delayed(const Duration(seconds: 1));
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {});
  }
}
