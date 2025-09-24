import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/core/provider/provider.dart';
import 'package:garage/data/enums/state_status.dart';
import 'package:garage/modules/login/login.dart';
import 'package:garage/modules/login/providers/login_state.dart';
import 'package:garage/routes/router.dart';
import 'package:garage/theme/app_colors.dart';
import 'package:garage/theme/app_gaps.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void _listenMessage(BuildContext context, WidgetRef ref) {
    ref.listen<LoginState>(loginProvider, (previous, next) {
      if (next.status == StateStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: Colors.red,
          ),
        );
      } else if (next.status == StateStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: Colors.green,
          ),
        );
        context.go(RouteNames.dashboard.asPath);
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _listenMessage(context, ref);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            // White container with login form
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: LoginForm(),
            ),
            AppGaps.gap20,
          ],
        ),
      ),
    );
  }
}
