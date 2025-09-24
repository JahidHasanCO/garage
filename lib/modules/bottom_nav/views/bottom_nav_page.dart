import 'package:flutter/material.dart';
import 'package:garage/modules/bottom_nav/bottom_nav.dart';
import 'package:garage/routes/router.dart';

class BottomNavPage extends StatelessWidget {
  const BottomNavPage({super.key});

  static final route = GoRoute(
    path: RouteNames.bottomNav.asPath,
    name: RouteNames.bottomNav,
    builder: (context, state) {
      return const BottomNavPage();
    },
  );

  @override
  Widget build(BuildContext context) {
    return const BottomNavScreen();
  }
}
