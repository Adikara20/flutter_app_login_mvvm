import 'package:flutter/material.dart';
import 'package:flutter_application_location/view/scanner/qr_scanner.dart';
import 'package:flutter_application_location/view/scanner/result_qr_scanner.dart';
import 'package:flutter_application_location/view/page/sign_up_screen.dart';
import 'package:flutter_application_location/view/page/splash_screen.dart';

import '../../view/page/home_screen.dart';
import '../../view/page/login_screen.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case RoutesName.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SingUpScreen());
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RoutesName.qrscan:
        return MaterialPageRoute(
            builder: (BuildContext context) => const QRScanner());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('No Route Define'),
              ),
            );
          },
        );
    }
  }
}
