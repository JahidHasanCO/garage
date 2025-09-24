import 'package:flutter/material.dart';
import 'package:garage/modules/login/views/login_screen.dart';
import 'package:garage/routes/router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static final route = GoRoute(
    path: RouteNames.login.asPath,
    name: RouteNames.login,
    builder: (context, state) => const LoginPage(),
  );

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
