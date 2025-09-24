import 'package:equatable/equatable.dart';
import 'package:garage/data/models/profile.dart';
import 'package:garage/data/models/user.dart';

class AppState extends Equatable {
  const AppState({
    this.accessToken,
    this.user,
    this.profile,
  });

  final String? accessToken;
  final User? user;
  final Profile? profile;

  AppState copyWith({
    String? accessToken,
    User? user,
    Profile? profile,
  }) {
    return AppState(
      accessToken: accessToken ?? this.accessToken,
      user: user ?? this.user,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [
    accessToken,
    user,
    profile,
  ];
}
