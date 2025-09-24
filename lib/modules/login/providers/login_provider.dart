import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/core/provider/provider.dart';
import 'package:garage/core/provider/repo.dart';
import 'package:garage/data/enums/state_status.dart';
import 'package:garage/data/models/user.dart';
import 'package:garage/modules/login/providers/login_state.dart';
import 'package:garage/shared/repo/auth_repo.dart';

class LoginProvider extends Notifier<LoginState> {
  late AuthRepo _repo;

  @override
  LoginState build() {
    _repo = ref.read(authRepoProvider);
    return const LoginState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: StateStatus.loading);
    final result = await _repo.login(email: email, password: password);
    if (result != null && (result.accessToken?.isNotEmpty ?? false)) {
      final token = result.accessToken!;
      await ref
          .read(appProvider.notifier)
          .setUser(
            token,
            result.user,
            result.profile,
          );
      state = state.copyWith(
        status: StateStatus.success,
        message: 'Login successful',
      );
    } else {
      state = state.copyWith(
        status: StateStatus.error,
        message: 'Login failed. Please check your credentials.',
      );
    }
  }
}
