import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/app/providers/app/app_state.dart';
import 'package:garage/data/models/profile.dart';
import 'package:garage/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends Notifier<AppState> {
  SharedPreferences? _prefs;

  @override
  AppState build() => const AppState();

  Future<void> onInit() async {
    _prefs = await SharedPreferences.getInstance();
    final token = _prefs?.getString('accessToken');
    final userJson = _prefs?.getString('user');
    final profileJson = _prefs?.getString('profile');
    if (token != null && userJson != null && profileJson != null) {
      final user = User.fromJson(userJson);
      final profile = Profile.fromJson(profileJson);
      state = state.copyWith(
        accessToken: token,
        user: user,
        profile: profile,
      );
    }
  }

  Future<void> setUser(
    String token,
    User? user,
    Profile? profile, {
    bool remember = true,
  }) async {
    if (remember) {
      _prefs ??= await SharedPreferences.getInstance();
      await _prefs?.setString('accessToken', token);
      await _prefs?.setString('user', user?.toJson() ?? '');
      await _prefs?.setString('profile', profile?.toJson() ?? '');
    }
    state = state.copyWith(accessToken: token, user: user);
  }
}
